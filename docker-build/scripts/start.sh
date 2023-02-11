#!/bin/bash

DIR="$( cd "$( dirname "$0"  )" && pwd  )"
bash -x $DIR/start-telegraf.sh
CONF_FILE=${TELEGRAF_HOME}/conf/telegraf.conf
echo "# Telegraf Configuration" >${CONF_FILE}
echo "[agent]" >>${CONF_FILE}
tail -f /dev/null
