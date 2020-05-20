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