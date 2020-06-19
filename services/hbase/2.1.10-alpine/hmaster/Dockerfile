FROM dockerhub.datagrand.com/yskg/hbase-base:2.1.10-alpine

MAINTAINER haojunyu <haojunyu@datagrand.com>

HEALTHCHECK CMD curl -f http://localhost:16010/ || exit 1

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 16000 16010

CMD ["/run.sh"]