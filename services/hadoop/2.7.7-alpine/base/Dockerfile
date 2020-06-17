FROM dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine AS build

# 下载所需软件
ENV HADOOP_VERSION 2.7.7
ENV HADOOP_URL ftp://ftp.datagrand.com:50100/apache/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

ADD entrypoint.sh /entrypoint.sh

RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \ 
    && apk add --no-cache curl \
    && curl -u yskg:27232d30cdc1  "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz* \
    && mv /opt/hadoop-$HADOOP_VERSION /opt/hadoop


FROM dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine
MAINTAINER haojunyu <haojunyu@datagrand.com>
USER root

COPY --from=build /opt/hadoop /opt/hadoop
COPY --from=build /entrypoint.sh /entrypoint.sh

RUN set -x \
    && ln -s /opt/hadoop/etc/hadoop /etc/hadoop \
    && cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml \
    && mkdir /opt/hadoop/logs \
    && mkdir /hadoop-data \
    && chmod a+x /entrypoint.sh

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV PATH $HADOOP_HOME/bin/:$PATH

ENTRYPOINT ["/entrypoint.sh"]