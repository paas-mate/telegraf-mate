#!/bin/bash

mkdir -p $TELEGRAF_HOME/logs
CONF_FILE=${TELEGRAF_HOME}/conf/telegraf.conf
nohup $TELEGRAF_HOME/usr/bin/telegraf --config ${CONF_FILE} >>$TELEGRAF_HOME/logs/telegraf.stdout.log 2>>$TELEGRAF_HOME/logs/telegraf.stderr.log &