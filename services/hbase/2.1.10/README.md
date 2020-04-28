# 基于服务的hbase分布式搭建


本版本参考 [big-data-europe][docker-hbase]发布的进行 hbase 集群的搭建，
并适用在公司。






## 问题
* endpoint_mode 要由默认的 vip 改为 dnsrr
* 3.1* 端口发生变化，需要更新


## 优势
* 按 hadoop 平台中的角色来分服务
* 通过 docker swarm 直接起集群，不需额外配置

## 分析镜像构建
### 镜像分层，配置统一
base
### 延迟启动
wait_for_it
### mode: global



## 改进
为了能够使用 docker stack 方式部署，创建了 docker-compose.yml 文件，并且作了如下的改动  
* endpoint_mode 由默认的 vip 改成了 dnsrr
vip 和 dnsrr 是 docker swarm 解决负载均衡问题的两种模式， 
vip 模式 会为每个服务分配独立的虚拟IP， DNS 记录会解析到服务名作为代理IP。
dnsrr 模式中， DNS不会解析 VIP， 而是去解析每个容器的IP。它有个坏处是不支持端口对外暴露。
所以针对 hadoop 中namenode 和 datanode 的部署，比较适合的是dnsrr模式。
* 构建nginx 代理容器来暴露hdfs和yarn的端口
```bash
docker run -itd --name proxyer -p 50071:50070 -p 8089:8088 -v $PWD/config/hadoop.conf:/etc/nginx/conf.d/hadoop.conf  --net=hadoop  nginx:latest
```
* 启动方式
```bash
docker network create --driver overlay --attachable  hadoop
docker stack deploy -c docker-compose.yml hadoop
```
## 缺陷
* swarm集群的持久化有问题，namenode空目录启动没有问题，但是当集群运行后重新启时，就会碰到datanode，namenode等容器
ip会发生变化，导致集群进入安全模式

```bash
# 进入master容器进行操作
docker exec -it `docker ps --filter name=hadoop-master --format "{{.ID}}"` bash
```

## 总结
这种方式的构建和实际hadoop平台构建方式类似，操作方面还是有些麻烦，并没有发挥docker的优势。





[big-data-europe发布][docker-hbase]


[docker-hbase]: https://github.com/big-data-europe/docker-hbase
