# Docker使用
### 1.dockerfile 与 docker-compose的区别
- dockerfile: 构建镜像；Dockerfile 就是这样的脚本，它记录了一个镜像的制作过程。有了 Dockerfile, 只要执行 docker build . 就能制作镜像，而且 Dockerfile 就是文本文件，修改也很方便。如果镜像是从 docker registry 拉取下来的，那么 Dockerfile 就不需要；如果镜像是需要 build 的，那就需要提供 Dockerfile.
- docker run: 启动容器；
- docker-compose: 启动服务；项目需要哪些镜像，每个镜像怎么配置，要挂载哪些 volume, 等等信息都包含在 docker-compose.yml 里。docker-compose.yml为 docker-compose 准备的脚本，可以同时管理多个 container ，包括他们之间的关系、用官方 image 还是自己 build 、各种网络端口定义、储存空间定义等

### 2.docker端口相关
- 和ports的区别是，expose不会将端口暴露给主机
- ports
```
# 绑定容器的80端口到主机的80端口
"80:80" 
# 绑定容器的8080端口到主机的9000端口
"9000:8080" 
# 绑定容器的443端口到主机的任意端口，容器启动时随机分配绑定的主机端口号
"443" 
```
### 3.docker 网络相关
- 单机上docker 容器之间的通信
- 内网docker容器之间的通信
- 公网docker容器之间的通信


### docker 性能查看
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# 保存镜像
docker save dockerhub.datagrand.com/nlp/pdf2txt:release_ci_20191017_85e0459 > pdf2txt-release_ci_20191017_85e0459.tar
# 加载镜像
docker load --input pdf2txt-release_ci_20191017_85e0459.tar



tar -czvf pdf2txt-release_ci_20191017_85e0459.tar.gz pdf2txt-release_ci_20191017_85e0459.tar
tar -xzvf pdf2txt-release_ci_20191017_85e0459.tar.gz

/usr/share/elasticsearch/config/analysis-ik/IKAnalyzer.cfg.xml


docker stack deploy --with-registry-auth --prune -c docker-compose.yml -c docker-compose.override.yml -c evaluate-extract-compose.yml -c extract-compose.yml  idps

docker exec -it `docker ps --filter name=bd-ha_nodemanager --format "{{.ID}}"` bash
 

docker exec -it `docker ps --filter name=jg_janusgraph --format "{{.ID}}"` bash


docker exec -it `docker ps --filter name=jg_elasticsearch --format "{{.ID}}"` bash


docker exec -it `docker ps --filter name=bg-es_elasticsearch --format "{{.ID}}"` bash

docker exec -it `docker ps --filter name=bd-hb_hmaster --format "{{.ID}}"` bash


docker exec -it `docker ps --filter name=hjy_kgflow --format "{{.ID}}"` bash


docker exec -it `docker ps --filter name=hjy_kg-api --format "{{.ID}}"` bash

export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop


docker exec -it `docker ps --filter name=bp_datanode2 --format "{{.ID}}"` bash




#Thu May 07 10:41:46 UTC 2020
namespaceID=1118802105
clusterID=CID-f4cc077b-1b7b-4e61-a20f-4dfe47b0816e
cTime=0
storageType=NAME_NODE
blockpoolID=BP-1271523882-13.14.15.89-1588738001346
layoutVersion=-63