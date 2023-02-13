#!/bin/bash

mkdir -p $TELEGRAF_HOME/logs
CONF_FILE=${TELEGRAF_HOME}/conf/telegraf.conf
echo "[agent]" >$CONF_FILE
echo '  interval = "10s"' >>$CONF_FILE
echo '  round_interval = true' >>$CONF_FILE
echo "[[inputs.cpu]]" >>$CONF_FILE
nohup $TELEGRAF_HOME/usr/bin/telegraf --config ${CONF_FILE} >>$TELEGRAF_HOME/logs/telegraf.stdout.log 2>>$TELEGRAF_HOME/logs/telegraf.stderr.log &
