FROM alpine:3.9 AS build

ENV ALPINE_GLIBC_VERSION="2.31-r0"
# 安装必要工具
RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add --no-cache wget \
    #&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget -O /etc/apk/keys/sgerrand.rsa.pub ftp://yskg:27232d30cdc1@ftp.datagrand.com:50100/alpine/sgerrand.rsa.pub \
    #&& wget -O https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$ALPINE_GLIBC_VERSION/glibc-$ALPINE_GLIBC_VERSION.apk \
    && wget ftp://yskg:27232d30cdc1@ftp.datagrand.com:50100/alpine/glibc-$ALPINE_GLIBC_VERSION.apk \
    && wget ftp://yskg:27232d30cdc1@ftp.datagrand.com:50100/alpine/glibc-bin-$ALPINE_GLIBC_VERSION.apk \
    && wget ftp://yskg:27232d30cdc1@ftp.datagrand.com:50100/alpine/glibc-i18n-$ALPINE_GLIBC_VERSION.apk \
    #&& wget -O jre-8u251-linux-x64.tar.gz  https://javadl.oracle.com/webapps/download/AutoDL?BundleId=242050_3d5a2bb8f8d4428bbe94aed7ec7ae784 \
    && wget ftp://yskg:27232d30cdc1@ftp.datagrand.com:50100/alpine/jre-8u251-linux-x64.tar.gz \
    && tar -xzvf jre-8u251-linux-x64.tar.gz \
    && mv jre1.8.0_251 java && cd java \
    && rm -rf COPYRIGHT LICENSE README release THIRDPARTYLICENSEREADME-JAVAFX.txt THIRDPARTYLICENSEREADME.txt Welcome.html \
            lib/plugin.jar \
            lib/ext/jfxrt.jar \
            bin/javaws \
            lib/javaws.jar \
            lib/desktop \
            plugin \
            lib/deploy* \
            lib/*javafx* \
            lib/*jfx* \
            lib/amd64/libdecora_sse.so \
            lib/amd64/libprism_*.so \
            lib/amd64/libfxplugins.so \
            lib/amd64/libglass.so \
            lib/amd64/libgstreamer-lite.so \
            lib/amd64/libjavafx*.so \
            lib/amd64/libjfx*.so


FROM alpine:3.9 

MAINTAINER datagrand <haojunyu@datagrand.com>
USER root

ENV ALPINE_GLIBC_VERSION="2.31-r0"
ENV LANG=C.UTF-8

# 拷贝项目
COPY --from=build /glibc-$ALPINE_GLIBC_VERSION.apk /glibc-$ALPINE_GLIBC_VERSION.apk
COPY --from=build /glibc-bin-$ALPINE_GLIBC_VERSION.apk /glibc-bin-$ALPINE_GLIBC_VERSION.apk
COPY --from=build /glibc-i18n-$ALPINE_GLIBC_VERSION.apk /glibc-i18n-$ALPINE_GLIBC_VERSION.apk
COPY --from=build /etc/apk/keys/sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
COPY --from=build /java /opt/java



# 安装必要工具
RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add --no-cache glibc-$ALPINE_GLIBC_VERSION.apk  \
                        glibc-bin-$ALPINE_GLIBC_VERSION.apk \
                        glibc-i18n-$ALPINE_GLIBC_VERSION.apk \
    && /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true \
    && echo "export LANG=$LANG" > /etc/profile.d/locale.sh \
    && apk del glibc-i18n \
    && rm glibc-$ALPINE_GLIBC_VERSION.apk glibc-bin-$ALPINE_GLIBC_VERSION.apk glibc-i18n-$ALPINE_GLIBC_VERSION.apk \
    && apk add --no-cache libstdc++ curl perl bash 
    #&& apk add --no-cache libc6-compat curl perl bash 
    

ENV JAVA_VERSION=8u251
ENV JAVA_HOME="/opt/java"
ENV PATH=$PATH:$JAVA_HOME/bin


