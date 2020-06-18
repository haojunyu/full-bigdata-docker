FROM dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine AS build

# 下载所需软件
ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=2.7
ENV SPARK_URL ftp://ftp.datagrand.com:50100/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz

ADD master.sh worker.sh /run/
RUN chmod a+x /run/*.sh

RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add --no-cache curl \
    && curl -u yskg:27232d30cdc1 "$SPARK_URL" -o /tmp/spark.tgz \
    && tar -xvf /tmp/spark.tgz -C /opt/ \
    && rm /tmp/spark.tgz* \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark


FROM dockerhub.datagrand.com/yskg/hadoop-base:2.7.7-alpine

MAINTAINER haojunyu <haojunyu@datagrand.com>
USER root

COPY --from=build /opt/spark /opt/spark
COPY --from=build /run /run

RUN mkdir /opt/spark/logs

EXPOSE 8080 7077 6066 8081


ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=2.7
ENV SPARK_HOME /opt/spark
ENV SPARK_LOG $SPARK_HOME/logs
ENV PATH $SPARK_HOME/bin/:$PATH
ENV SPARK_DIST_CLASSPATH "/etc/hadoop:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:/third_party_jars/*.jar"
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_MASTER "spark://master:7077"