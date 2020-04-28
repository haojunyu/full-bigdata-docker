FROM datagrand/hbase-base:2.1.10

MAINTAINER haojunyu <haojunyu@datagrand.com>

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 16020 16030

CMD ["/run.sh"]