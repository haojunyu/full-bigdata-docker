FROM zookeeper:latest
ENV LANG en_US.utf8
RUN apt-get install tzdata
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo Asia/Shanghai > /etc/timezone