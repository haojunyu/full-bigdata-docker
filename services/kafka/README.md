# kafka 安装部署

## 镜像生成
### official
使用 [dockerhub][official] 上 wurstmeister 提供的镜像为基准，使用的标签是 lastest，对应的版本为1.1.0。



### 1.0.1


## 分布式集群部署
分布式集群部署依赖 bigdata 网络，如果没有可以新建
```bash
## 查看当前所有网络
docker network ls
## 创建bigdata的网络(swarm, overlay)
docker network create --driver overlay --subnet 13.14.15.0/24 --ip-range 13.14.15.0/24 --gateway 13.14.15.1 bigdata
```
### official
#### 原生部署
原生部署使用 docker-compose.yml 配置的环境变量生成 zoo.cfg 和 myid 配置文件。具体配置参考[该篇博文][zookeeper_swarm] 或查看镜像中 /docker-entrypoint.sh 文件。此外配置目录，数据目录，日志目录都在容器中，没有持久化，删除容器会丢失数据。

部署常用命令如下：
```bash
## 切换到official目录，该目录有 docker-compose.yml
cd services/zookeeper/official
## 启集群
docker stack deploy -c docker-compose.yml --with-registry-auth zk
## 查看集群状态
docker stack services zk
## 查看服务状态
docker service logs --no-trunc zk_zoo1
## 查看3个容器的角色：1个leader，2个follower
docker exec -it zoo1_container zkServer.sh status
docker exec -it zoo2_container zkServer.sh status
docker exec -it zoo3_container zkServer.sh status
```


#### 外挂数据部署
外挂数据部署通过挂载配置文件，数据文件和日志文件的方式启动容器集群。
部署常用命令如下：
```bash
## 切换到根目录，该目录有 zookeeper.yml
cd .
## 启集群
docker stack deploy -c zookeeper.yml --with-registry-auth zk
## 查看集群状态
docker stack services zk
## 查看服务状态
docker service logs --no-trunc zk_zoo1
## 查看3个容器的角色：1个leader，2个follower
docker exec -it zoo1_container zkServer.sh status
docker exec -it zoo2_container zkServer.sh status
docker exec -it zoo3_container zkServer.sh status
```


部署验证

## 参考
1. [kafka热门镜像](official)
2. [zookeeper集群docker搭建](zookeeper_swarm)
3. [kafka管理服务][kafka_manager]
4. [kafka中文官网][kafka_org]


[official]: https://hub.docker.com/r/wurstmeister/kafka/dockerfile
[kafka_swarm]: http://jaychang.cn/2018/05/05/Docker%E4%B8%8BZookeeper%E9%9B%86%E7%BE%A4%E6%90%AD%E5%BB%BA/
[kafka_manager]: https://hub.docker.com/r/kafkamanager/kafka-manager
[kafka_org]: http://kafka.apachecn.org/intro.html