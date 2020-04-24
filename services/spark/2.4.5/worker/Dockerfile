FROM datagrand/os-jvm:centos7-openjdk8

MAINTAINER haojunyu <haojunyu@datagrand.com>

HEALTHCHECK CMD curl -f http://localhost:8081/ || exit 1

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_MASTER "spark://master:7077"
ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8081

CMD ["/run.sh"]