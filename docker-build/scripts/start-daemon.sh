#!/bin/bash

mkdir -p $TELEGRAF_HOME/logs
nohup $TELEGRAF_HOME/mate/telegraf-mate >>$TELEGRAF_HOME/logs/telegraf_mate.stdout.log 2>>$TELEGRAF_HOME/logs/telegraf_mate.stderr.log &
