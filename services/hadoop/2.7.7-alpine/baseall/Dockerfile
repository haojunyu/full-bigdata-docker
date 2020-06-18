FROM dockerhub.datagrand.com/yskg/hadoop-base:2.7.7-alpine

ADD namenode.sh datanode.sh nodemanager.sh resourcemanager.sh historyserver.sh /run/

RUN set -x \
    && mkdir -p /hadoop-data hadoop/dfs/name hadoop/dfs/data /hadoop/yarn/timeline \
    && chmod a+x /run/*.sh

VOLUME ["/hadoop/dfs/name","/hadoop/dfs/data","/hadoop/yarn/timeline"]
EXPOSE 50070 50075 8042 8088 8188

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline