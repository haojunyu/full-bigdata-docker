FROM dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine AS build

# 下载所需软件
ENV HADOOP_VERSION 2.7.7
ENV HADOOP_URL ftp://ftp.datagrand.com:50100/apache/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

ADD entrypoint.sh /entrypoint.sh
ADD namenode.sh datanode.sh nodemanager.sh resourcemanager.sh historyserver.sh /run/
RUN chmod a+x /run/*.sh

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
COPY --from=build /run /run

RUN set -x \
    && ln -s /opt/hadoop/etc/hadoop /etc/hadoop \
    && cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml \
    && mkdir -p /opt/hadoop/logs /hadoop-data hadoop/dfs/name hadoop/dfs/data /hadoop/yarn/timeline \
    && chmod a+x /entrypoint.sh

VOLUME ["/hadoop/dfs/name","/hadoop/dfs/data","/hadoop/yarn/timeline"]
EXPOSE 50070 50075 8042 8088 8188

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
ENV MULTIHOMED_NETWORK=1
ENV PATH $HADOOP_HOME/bin/:$PATH

ENTRYPOINT ["/entrypoint.sh"]