#!/usr/bin/env bash

cat << EOF >> /root/.ipython/profile_pyspark/ipython_notebook_config.py
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8888
EOF

export PYSPARK_SUBMIT_ARGS="--master spark://$SPARK_MASTER_IP:7077 --executor-memory $SPARK_EXECUTOR_RAM $SPARK_OPTIONS pyspark-shell"

echo "PySpark options:" $PYSPARK_SUBMIT_ARGS

ipython notebook --profile=pyspark

