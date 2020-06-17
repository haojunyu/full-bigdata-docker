# 安装kafka
brew install kafka

# 查看kafka中所有的组
kafka-consumer-groups --bootstrap-server localhost:9092 --list
# 查看kafka中对应组消费端的堆积量
kafka-consumer-groups --bootstrap-server localhost:9092 --group (groupname) --describe

# 查看kafka中的所有主题
kafka-topics --zookeeper localhost:2181 --list
# 查看主题topicname的信息
kafka-topics --zookeeper localhost:2181 --topic (topicname) --describe
# 创建主题为topicA的消息队列
kafka-topics --zookeeper localhost:2181 --create --replication-factor 1 --partitions 1 --topic topicA
# 通过终端的方式生成消息
kafka-console-producer.sh --broker-list localhost:9092 --topic topicA
# 手动消费主题topicA的消息队列
kafka-console-consumer --bootstrap-server localhost:9092 --topic topicA --from-beginning



更新步骤：（当前在yskg-deploy目录下）
1. 备份docker-compose.yml和data/kbqa文件夹
mv docker-compose.yml docker-compose.yml.bak
mv data/kbqa data/kbqa_bak

2. 拷贝两个文件
cp xxx/docker-compose.yml .
tar  -xzvf xxx/kbqa.tar.gz -C data/

3. 重启yskg服务
Docker stack rm yskg && make yskg 