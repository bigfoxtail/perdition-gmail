#!/bin/bash

/etc/init.d/rsyslog start
rm -v /var/run/perdition.imap4/perdition.imap4.pid
rm -v /var/run/perdition.imaps/perdition.imaps.pid
rm -v /var/run/perdition.pop3/perdition.pop3.pid
rm -v /var/run/perdition.pop3s/perdition.pop3s.pid
rm -v /var/run/perdition.managesieve/perdition.managesieve.pid
/etc/init.d/perdition start
tail -f /var/log/syslog
