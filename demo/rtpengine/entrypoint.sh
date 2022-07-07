#!/bin/bash
set -e

PATH=/usr/local/bin:$PATH

: ${PRIVATE_IPV4="$(netdiscover -field privatev4 ${PROVIDER})"}
: ${PUBLIC_IPV4="$(netdiscover -field publicv4 ${PROVIDER})"}
: ${PUBLIC_IPV6:="$(netdiscover -field publicv6 ${PROVIDER})"}
: ${PUBLIC_HOSTNAME="$(netdiscover -field hostname ${PROVIDER})"}

if [ -n "$PUBLIC_IPV4" ]; then
  MY_IP=$PRIVATE_IPV4
else
  PUBLIC_IP=$PRIVATE_IPV4
  MY_IP=$PUBLIC_IP
fi

echo $(sed "s/XXXXXX-XXXXXX/${PUBLIC_IPV6}/g") > /etc/rtpengine/rtpengine.conf
echo $(sed "s/XXXXX-XXXXX/${PUBLIC_IPV4}/g") > /etc/rtpengine/rtpengine.conf

cat /etc/rtpengine/rtpengine.conf

if [ "$1" = 'rtpengine' ]; then
  shift
  exec rtpengine --config-file /etc/rtpengine/rtpengine.conf  "$@"
fi


exec "$@"
