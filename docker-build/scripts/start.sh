#!/bin/bash

DIR="$( cd "$( dirname "$0"  )" && pwd  )"
bash -x $DIR/start-telegraf.sh
CONF_FILE=${TELEGRAF_HOME}/conf/telegraf.conf
echo "# Telegraf Configuration" > ${CONF_FILE}
echo "[agent]" >> ${CONF_FILE}
# config agent
interval="10s"
if [ "$AGENT_INTERVAL" ]; then
    interval=$AGENT_INTERVAL
fi
metric_batch_size=1000
if [ "$AGENT_METRIC_BATCH_SIZE" ]; then
    metric_batch_size=$AGENT_METRIC_BATCH_SIZE  >> ${CONF_FILE}
fi
metric_buffer_limit=10000
if [ "$AGENT_METRIC_BUFFER_LIMIT" ]; then
    metric_buffer_limit=$AGENT_METRIC_BUFFER_LIMIT
fi
collection_jitter="0s"
if [ "$AGENT_COLLECTION_JITTER" ]; then
    collection_jitter=$AGENT_COLLECTION_JITTER
fi
flush_interval="10s"
if [ "$AGENT_FLUSH_INTERVAL" ]; then
    flush_interval=$AGENT_FLUSH_INTERVAL
fi
flush_jitter="0s"
if [ "$AGENT_FLUSH_JITTER" ]; then
    flush_jitter=$AGENT_FLUSH_JITTER
fi
echo "  interval = \"$interval\"" >> ${CONF_FILE}
echo "  round_interval = true" >> ${CONF_FILE}
echo "  metric_batch_size = $metric_batch_size"
echo "  metric_buffer_limit = $metric_buffer_limit" >> ${CONF_FILE}
echo "  collection_jitter = $collection_jitter" >> ${CONF_FILE}
echo "  flush_interval = $flush_interval" >> ${CONF_FILE}
echo "  flush_jitter = $flush_jitter" >> ${CONF_FILE}
echo "  precision=\"\"" >> ${CONF_FILE}
echo "  hostname = \"\"" >> ${CONF_FILE}
echo "  omit_hostname = false" >> ${CONF_FILE}

echo "[[inputs.cpu]]" >> ${CONF_FILE}
echo "  percpu = true" >> ${CONF_FILE}
echo "  totalcpu = true" >> ${CONF_FILE}
echo "  collect_cpu_time = false" >> ${CONF_FILE}
echo "  report_active = false" >> ${CONF_FILE}
echo "  core_tags = false" >> ${CONF_FILE}

echo "[[inputs.mem]]" >> ${CONF_FILE}

if [ "$ENABLE_INFLUXDB_V2" = "true" ]; then
    echo "[[outputs.influxdb_v2]]" >> ${CONF_FILE}
    echo "  urls = [\"http://$INFLUXDB_HOST:$INFLUXDB_PORT\"]" >> ${CONF_FILE}
    echo "  token = \"$INFLUXDB_V2_TOKEN\"" >> ${CONF_FILE}
    echo "  organization = \"$INFLUXDB_V2_ORG\"" >> ${CONF_FILE}
    echo "  bucket = \"$INFLUXDB_V2_BUCKET\"" >> ${CONF_FILE}
else
    echo "[[outputs.influxdb]]" >> ${CONF_FILE}
    echo "  urls = [\"http://$INFLUXDB_HOST:$INFLUXDB_PORT\"]" >> ${CONF_FILE}
    skip_database_creation=true
    if [ "$INFLUXDB_SKIP_DATABASE_CREATION" ]; then
        skip_database_creation=$INFLUXDB_SKIP_DATABASE_CREATION
    fi
    echo "  skip_database_creation = $skip_database_creation" >> ${CONF_FILE}
    echo "  password = \"$INFLUXDB_PASSWORD\"" >> ${CONF_FILE}
fi
tail -f /dev/null
