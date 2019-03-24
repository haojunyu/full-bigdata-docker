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
