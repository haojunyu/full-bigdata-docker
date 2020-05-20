FROM datagrand/os-jvm:centos7-openjdk8

MAINTAINER haojunyu <haojunyu@datagrand.com>

USER root

RUN yum update -y && \
    yum install -y net-tools curl nc perl which &&\
    yum clean all

ENV HBASE_VERSION=2.2.4

ENV HBASE_URL https://mirrors.tuna.tsinghua.edu.cn/apache/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz
RUN set -x \
    && curl -fSL "$HBASE_URL" -o /tmp/hbase.tar.gz \
    && tar -xvf /tmp/hbase.tar.gz -C /opt/ \
    && rm /tmp/hbase.tar.gz*

RUN ln -s /opt/hbase-${HBASE_VERSION} /opt/hbase
RUN ln -s /opt/hbase-${HBASE_VERSION}/conf /etc/hbase
RUN mkdir /opt/hbase/logs
RUN mkdir /hadoop-data

ENV HBASE_HOME /opt/hbase
ENV HBASE_LOG $HBASE_HOME/logs
ENV HBASE_CONF_DIR /etc/hbase
ENV PATH $HBASE_HOME/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
