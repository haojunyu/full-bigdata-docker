FROM wurstmeister/kafka
ENV LANG en_US.utf8
RUN apk add -U tzdata
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo Asia/Shanghai > /etc/timezone