#!/usr/bin/env bash

mkdir /tmp/spark-submit
cd  /tmp/spark-submit

echo "Downloading application from ${APPLICATION_URL}"
curl "${APPLICATION_URL}" --retry 5 --retry-delay 2 -o app.zip
unzip app.zip

/opt/spark/bin/spark-submit --master spark://${SPARK_MASTER_IP}:7077 --executor-memory=${SPARK_EXECUTOR_RAM} ${SPARK_OPTIONS} "$@"

