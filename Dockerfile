FROM debian:buster as builder

WORKDIR /build
COPY patches/ /build/patches/
RUN \
    chmod a+w /build && \
    echo "deb-src http://deb.debian.org/debian buster main" >> /etc/apt/sources.list && \
    echo "deb-src http://security.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian buster-updates main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y build-essential && \
    apt-get source perdition=2.2-3+b3 && \
    apt-get build-dep -y perdition=2.2-3+b3 && \
    cd perdition-2.2 && \
    cp -r /build/patches/ debian/patches/ && \
    dpkg-buildpackage -us -uc && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

FROM debian:buster-slim

COPY --from=builder /build/perdition_2.2-3_amd64.deb /root/
RUN \
    apt-get update && \
    dpkg -i /root/perdition_2.2-3_amd64.deb || true && \
    apt-get install -y -f && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rsyslog procps ca-certificates && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY perdition/default-perdition /etc/default/perdition
COPY perdition/* /etc/perdition/
COPY main.sh /

RUN openssl dhparam -out /etc/perdition/dhparam.pem 2048

EXPOSE 110/tcp 143/tcp 993/tcp 995/tcp

WORKDIR /etc/perdition

ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]
