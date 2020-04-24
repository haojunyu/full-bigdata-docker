FROM datagrand/hadoop-base:2.7.7

MAINTAINER haojunyu <haojunyu@datagrand.com>

USER root

RUN yum update -y && \
    yum install -y net-tools curl nc perl which &&\
    yum clean all

ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=2.7

ENV SPARK_URL https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz
RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tgz \
    && tar -xvf /tmp/spark.tgz -C /opt/ \
    && rm /tmp/spark.tgz*

RUN ln -s /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark
RUN mkdir /opt/spark/logs

ENV SPARK_HOME /opt/spark
ENV SPARK_LOG $SPARK_HOME/logs
ENV PATH $SPARK_HOME/bin/:$PATH
ENV SPARK_DIST_CLASSPATH "/etc/hadoop:$HADOOP_PREFIX/share/hadoop/common/lib/*:$HADOOP_PREFIX/share/hadoop/common/*:$HADOOP_PREFIX/share/hadoop/hdfs:$HADOOP_PREFIX/share/hadoop/hdfs/lib/*:$HADOOP_PREFIX/share/hadoop/hdfs/*:$HADOOP_PREFIX/share/hadoop/yarn/lib/*:$HADOOP_PREFIX/share/hadoop/yarn/*:$HADOOP_PREFIX/share/hadoop/mapreduce/lib/*:$HADOOP_PREFIX/share/hadoop/mapreduce/*:/third_party_jars/*.jar"

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]