# 别人的分布式
本版本参考 [基于Docker搭建Hadoop集群之升级版][hadoop-cluster-docker]进行 hadoop 集群的搭建，
但该集群只能通过 start-container.sh 启动，而无法使用 docker stack 方式部署。

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
* 每个容器都会格式化namenode， 当然只有主节点的namenode是在使用中的
* hadoop和yarn的启动都得进入容器中手动启
```bash
# 进入master容器进行操作
docker exec -it `docker ps --filter name=hadoop-master --format "{{.ID}}"` bash
```

## 总结
这种方式的构建和实际hadoop平台构建方式类似，操作方面还是有些麻烦，并没有发挥docker的优势。

[基于Docker搭建Hadoop集群之升级版][hadoop-cluster-docker]
[docker下，极速搭建spark集群(含hdfs集群)][hadoop-spark-docker]

[hadoop-cluster-docker]: https://github.com/kiwenlau/hadoop-cluster-docker
[hadoop-spark-docker]:https://blog.csdn.net/boling_cavalry/article/details/86851069