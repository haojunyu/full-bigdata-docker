FROM datagrand/hbase-base:2.2.4

MAINTAINER haojunyu <haojunyu@datagrand.com>

HEALTHCHECK CMD curl -f http://localhost:16010/ || exit 1

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]