FROM datagrand/os-jvm:centos7-openjdk8

MAINTAINER datagrand <haojunyu@datagrand.com>

USER root

ENV ZOOKEEPER_HOME=/root/zookeeper
ENV PATH=$PATH:.:$ZOOKEEPER_HOME/bin

# 1. 安装 zookeeper 3.4.6
RUN wget http://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz && \
  tar -xzvf zookeeper-3.4.6.tar.gz -C /root/ && \
  mv /root/zookeeper-3.4.6 $ZOOKEEPER_HOME && \
  rm -rf zookeeper-3.4.6.tar.gz && \
  rm -rf $ZOOKEEPER_HOME/bin/*.cmd && \
  rm -rf $ZOOKEEPER_HOME/dist-maven && \
  rm -rf $ZOOKEEPER_HOME/docs && \
  rm -rf $ZOOKEEPER_HOME/src

# 开放2181端口
EXPOSE 2181

# 拷贝zookeeper配置文件
ADD config/zoo.cfg $ZOOKEEPER_HOME/conf/

CMD ["sh", "-c", "$ZOOKEEPER_HOME/bin/zkServer.sh start; bash"]