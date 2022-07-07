FROM debian:buster

MAINTAINER Jerry Drung "efficacy38@gmail.com"

RUN apt update \
  && apt-get install -y wget gnupg curl \
  && wget -q -O - https://deb.sipwise.com/spce/keyring/sipwise-keyring-bootstrap.gpg | apt-key add - \
  && echo 'deb https://deb.sipwise.com/spce/mr9.4.1/ buster main' > /etc/apt/sources.list.d/sipwise.list \
  && echo 'deb-src https://deb.sipwise.com/spce/mr9.4.1/ buster main' >> /etc/apt/sources.list.d/sipwise.list \
  && apt-get update \
  && apt-get -y install ngcp-rtpengine \
  && rm -rf /var/lib/apt/* \
  && rm -rf /var/lib/cache/* \
  && rm -Rf /var/log/* \
  && rm -Rf /usr/local/src/* \
  && rm -Rf /var/lib/apt/lists/* 
  # && rm -rf /var/lib/dpkg/* \

VOLUME ["/tmp"]

EXPOSE 23000-32768/udp 22222/udp

# Download netdiscover
RUN curl -qL -o /usr/bin/netdiscover https://github.com/CyCoreSystems/netdiscover/releases/download/v1.2.5/netdiscover.linux.amd64
RUN chmod +x /usr/bin/netdiscover

COPY ./entrypoint.sh /entrypoint.sh

COPY ./rtpengine.conf /etc/rtpengine

ENTRYPOINT ["/entrypoint.sh"]

CMD ["rtpengine"]
