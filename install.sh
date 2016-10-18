#!/bin/bash

set -m
CONFIG_FILE="/etc/collectd.conf"

if [[ -n ${1} ]] ;then
  INFLUX_HOST=${1}
else
  INFLUX_HOST="localhost"
fi
if [[ -n $2 ]]; then
  INFLUX_API_PORT=$2
else
  INFLUX_API_PORT="8086"
fi

# Add Collectd support
yum install -y epel-release
yum install -y collectd

echo "enable network plugin"
sed -i -r -e "/^\#LoadPlugin\ network/ { s/\#//g;}" ${CONFIG_FILE}
sed -i -r -e "/^\#<Plugin\ network>/ { s/\#//g;}" ${CONFIG_FILE}
sed -i -r -e "/^<Plugin\ network>/, /^$/ { s/^#.*Server\ .*\ .*\"$/Server \"${INFLUX_HOST}\"\ \"${INFLUX_API_PORT}\"/g;}" ${CONFIG_FILE}
echo "Configuraton of collectd is as follows"
cat ${CONFIG_FILE}
echo "start collectd service"
systemctl start collectd
