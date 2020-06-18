FROM dockerhub.datagrand.com/yskg/spark-base:2.4.5-hadoop2.7.7-alpine

MAINTAINER haojunyu <haojunyu@datagrand.com>

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8080 7077 6066

CMD ["/run.sh"]