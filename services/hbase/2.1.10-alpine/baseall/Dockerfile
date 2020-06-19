FROM dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine AS build

ENV HBASE_VERSION=2.1.10
ENV HBASE_URL ftp://ftp.datagrand.com:50100/apache/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz

ADD entrypoint.sh /entrypoint.sh
ADD hmaster.sh hregionserver.sh /run/
RUN chmod a+x /run/*.sh

RUN set -x \
    && curl -u yskg:27232d30cdc1  "$HBASE_URL" -o /tmp/hbase.tar.gz \
    && tar -xvf /tmp/hbase.tar.gz -C /opt/ \
    && rm /tmp/hbase.tar.gz* \
    && mv /opt/hbase-${HBASE_VERSION} /opt/hbase

FROM dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine
MAINTAINER haojunyu <haojunyu@datagrand.com>
USER root

COPY --from=build /opt/hbase /opt/hbase
COPY --from=build /entrypoint.sh /entrypoint.sh
COPY --from=build /run /run


RUN ln -s /opt/hbase/conf /etc/hbase \
    &&  mkdir /opt/hbase/logs /hadoop-data \
    && chmod a+x /entrypoint.sh

EXPOSE 16000 16010 16020 16030

ENV HBASE_VERSION=2.1.10
ENV HBASE_HOME /opt/hbase
ENV HBASE_LOG $HBASE_HOME/logs
ENV HBASE_CONF_DIR /etc/hbase
ENV PATH $HBASE_HOME/bin/:$PATH

ENTRYPOINT ["/entrypoint.sh"]