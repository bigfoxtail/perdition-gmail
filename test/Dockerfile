FROM debian:buster-slim


COPY perdition_2.2-3_amd64.deb /root/

RUN \
    apt-get update && \
    dpkg -i /root/perdition_2.2-3_amd64.deb || true && \
    apt-get install -y -f && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    rsyslog \
    procps \
    ca-certificates && \
    apt-get clean

COPY perdition/default-perdition /etc/default/perdition
COPY perdition/* /etc/perdition/
COPY main.sh /

RUN openssl dhparam -out /etc/perdition/dhparam.pem 2048

EXPOSE 110/tcp 143/tcp 993/tcp 995/tcp

WORKDIR /etc/perdition

ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]
