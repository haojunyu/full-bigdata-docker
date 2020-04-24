#!/bin/bash

export SPARK_HOST=`hostname`

. "/spark/sbin/spark-config.sh"

. "/spark/bin/load-spark-env.sh"



$SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master \
    --ip $SPARK_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_LOG/spark-master.out
