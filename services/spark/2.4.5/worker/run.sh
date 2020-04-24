#!/bin/bash

. "/spark/sbin/spark-config.sh"

. "/spark/bin/load-spark-env.sh"

$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker \
  --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_LOG/spark-worker.out
