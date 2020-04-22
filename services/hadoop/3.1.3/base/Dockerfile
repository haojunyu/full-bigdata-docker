FROM datagrand/os-jvm:centos7-openjdk8

MAINTAINER haojunyu <haojunyu@datagrand.com>

USER root

RUN yum update -y && \
    yum install -y net-tools curl nc perl &&\
    yum clean all

ENV HADOOP_VERSION 3.1.3
ENV HADOOP_URL https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

ENV PATH $HADOOP_PREFIX/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]