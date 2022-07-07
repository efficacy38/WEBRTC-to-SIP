FROM debian:buster

RUN apt-get update && \
    apt-get install -y curl procps gnupg2 sngrep jq && \
    apt-get clean

# Install kamailio
RUN curl -qO http://deb.kamailio.org/kamailiodebkey.gpg && \
    apt-key add kamailiodebkey.gpg && \
    echo "deb http://deb.kamailio.org/kamailio56 buster main\ndeb-src http://deb.kamailio.org/kamailio56 buster main" > /etc/apt/sources.list.d/kamailio.list
RUN apt-get update &&  apt-get install -y kamailio kamailio-websocket-modules kamailio-mysql-modules kamailio-tls-modules kamailio-presence-modules && apt-get clean

# Download netdiscover
RUN curl -qL -o /usr/bin/netdiscover https://github.com/CyCoreSystems/netdiscover/releases/download/v1.2.5/netdiscover.linux.amd64
RUN chmod +x /usr/bin/netdiscover

# Install configs
ADD config /etc/kamailio

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
# ENTRYPOINT ["kamailio", "-DD", "-E", "-f", "/etc/kamailio/kamailio.cfg"]

CMD []
