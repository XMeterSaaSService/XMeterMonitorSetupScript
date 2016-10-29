#!/bin/bash

if [[ $# -ne 2 || "$1" == "help" ]] ; then
	echo "Usage: $0 <influx server> <influx server port>"
	exit 1
fi

[ -e /etc/redhat-release ] || ( echo "Sorry, we cannot install collectd for your OS type at this moment, please consider manual install collectd and configure it to point to influx server" && exit 2 )

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
