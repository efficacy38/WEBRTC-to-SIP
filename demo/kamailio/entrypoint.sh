#!/bin/bash
# Set default settings, pull repository, build
# app, etc., _if_ we are not given a different
# command.  If so, execute that command instead.
set -e

# Default values
: ${PID_FILE:="/var/run/kamailio.pid"}
: ${KAMAILIO_ARGS:="-DD -E -f /etc/kamailio/kamailio.cfg -P ${PID_FILE}"}

# confd requires that these variables actually be exported
export PID_FILE

# Make dispatcher.list exists
# mkdir -p /data/kamailio
# touch /data/kamailio/dispatcher.list

# if not define environment variable PRIVATE_IPV4, PUBLIC_IPV4, PUBLIC_HOSTNAME, we would find the ip automatically
: ${PRIVATE_IPV4:="$(netdiscover -field privatev4 ${PROVIDER})"}
: ${PUBLIC_IPV4:="$(netdiscover -field publicv4 ${PROVIDER})"}
: ${PUBLIC_IPV6:="$(netdiscover -field publicv6 ${PROVIDER})"}
: ${PUBLIC_HOSTNAME="$(netdiscover -field hostname ${PROVIDER})"}

echo $(sed 's/XXXXXX-XXXXXX/PUT-IPV6-OF-YOUR-SIP-SERVER-HERE/g') > /etc/kamailio.cfg
echo $(sed 's/XXXXX-XXXXX/PUT-IPV4-OF-YOUR-SIP-SERVER-HERE/g') > /etc/kamailio.cfg
echo $(sed 's/XXXX-XXXX/PUT-DOMAIN-OF-YOUR-SIP-SERVER-HERE/g') > /etc/kamailio.cfg

# Runs kamaillio, while shipping stderr/stdout to logstash
exec /usr/sbin/kamailio $KAMAILIO_ARGS $*
