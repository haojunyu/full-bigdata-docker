# 基于服务的spark-hadoop分布式集群搭建





curl localhost:8018     
curl localhost:50072   hdfs页面
curl localhost:8086   yarn



## 验证
```bash
# spark 单点验证
run-example SparkPi 10
# spark standalone任务提交
spark-submit --class org.apache.spark.examples.SparkPi --master spark://master:7077 --driver-memory 512m --executor-memory 512m --total-executor-cores 2 /opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar 100

# spark yarn client 调度
spark-submit --class org.apache.spark.examples.SparkPi  --master yarn  --driver-memory 512m --executor-memory 512m --total-executor-cores 2  /opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar 100

# spark yarn cluster 调度
spark-submit --class org.apache.spark.examples.SparkPi  --master yarn-cluster  --driver-memory 512m --executor-memory 512m --total-executor-cores 2  /opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar 100

# spark 读写hadoop
wget https://raw.githubusercontent.com/zq2599/blog_demos/master/sparkdockercomposefiles/sparkwordcount-1.0-SNAPSHOT.jar

spark-submit --class com.bolingcavalry.sparkwordcount.WordCount --executor-memory 512m --total-executor-cores 2 /sparkwordcount-1.0-SNAPSHOT.jar namenode 9000 tmp.txt

````

```scale
# spark 读hadoop  在spark-shell中执行, /input/tmp.txt需要在hadoop容器中创建
sc.textFile("hdfs://namenode:9000/input/tmp.txt").flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _).sortBy(_._2,false).take(10).foreach(println)

```
--jars extra_jars/jersey-bundle-1.17.1.jar


export SPARK_DIST_CLASSPATH=$(hadoop classpath)


=======================


本版本参考 [big-data-europe][apache-hadoop-docker]发布的进行 spark 集群的搭建，
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





[big-data-europe发布][apache-hadoop-docker]
[docker下，极速搭建spark集群(含hdfs集群)][hadoop-pratice]


[apache-hadoop-docker]: https://github.com/big-data-europe/docker-hadoop
[hadoop-pratice]: https://blog.csdn.net/boling_cavalry/article/details/86851069




curl -0 -X POST http://127.0.0.1:59000/KgApi/D2r/start -H "Content-Type: application/x-ndjson" -d '{"d2rKgflowETLReqBean":{"group":"xxx","name":"TestFlowGroup","uuid":"1111111111111","flows":[{"dataSetId":7,"modules":[{"name":"输入2","type":"csv","uuid":"输入2","properties":{"sourceName":"MySQL测试","tableName":"anno_annotation","incremental":{"referenceField":"id","updateStrategy":"manual","filter":">","referenceValue":"100"},"header":false,"delimiter":",","path":"hdfs:///namenode:9000/test.csv","columns":"code,name,vertex_label,code_2,edge_label,prop_1,prop2,prop3,prop1_key,prop2_key"},"position":""},{"name":"选择","type":"fieldSelect","uuid":"选择","properties":{"propertyValues":[{"sourceField":"prop3","newField":"prop3_new","sourceModuleId":"a87f65d1"}]},"position":""},{"name":"聚合2","type":"aggregate","uuid":"聚合2","properties":{"propertyValues":[{"newField":"agg_code","sourceField":"code","groupField":"vertex_label","function":"count"}]},"position":""},{"name":"计算器4","type":"calculator","uuid":"计算器4","properties":{"propertyValues":[{"newField":"prop1+2","expr":"A+B","sourceFieldA":"prop_1","sourceFieldB":"prop2"}]},"position":""},{"name":"end","type":"output","uuid":"end","properties":{"propertyValues":[]},"position":""}],"edges":[{"uuid":"9d279618","sourceId":"输入2","targetId":"选择","position":"","outport":"","inport":"data2"},{"uuid":"26fee6f4","sourceId":"选择","targetId":"聚合2","position":""},{"uuid":"33f70881","sourceId":"聚合2","targetId":"计算器4","position":""},{"uuid":"b9c0f213","sourceId":"计算器4","targetId":"end","position":""}]}]},"d2rKgflowLoadReqBean":{"createTime":1578553826,"cron":"* * * * * *","edges":[{"label":"edge_label","properties":[],"sourcePath":"7","sourceCodeColumn":"code","targetCodeColumn":"code_2"},{"label":"edge_label","properties":[{"column":"prop12","key":"prop1_key","type":"整数值"}],"sourceCodeColumn":"code","targetCodeColumn":"code_2","sourcePath":"7"}],"taskId":"test_map1_1568818020","taskInfo":"xxxx","taskName":"xx","vertexes":[{"codeColumn":"code","label":"vertex_label","properties":[],"sourcePath":"7","tagColumn":"id"},{"codeColumn":"code_2","label":"vertex_label","properties":[{"column":"prop2","key":"prop2_key","type":"整数值"}],"sourcePath":"7"}],"whichGraph":"test_map1","ip":"0.0.0.0","port":"50000","hdfs":false,"incr":false}}'