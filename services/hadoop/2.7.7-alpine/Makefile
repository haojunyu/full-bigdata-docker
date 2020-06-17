DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch = 2.7.7
build:
	sudo docker-compose -f docker-compose-build.yml build --no-cache base
	sudo docker-compose -f docker-compose-build.yml build --no-cache namenode
	sudo docker-compose -f docker-compose-build.yml build --no-cache datanode
	sudo docker-compose -f docker-compose-build.yml build --no-cache resourcemanager
	sudo docker-compose -f docker-compose-build.yml build --no-cache nodemanager
	sudo docker-compose -f docker-compose-build.yml build --no-cache historyserver

push:
	sudo docker login dockerhub.datagrand.com
	sudo docker-compose -f docker-compose-build.yml push base
	sudo docker-compose -f docker-compose-build.yml push namenode
	sudo docker-compose -f docker-compose-build.yml push datanode
	sudo docker-compose -f docker-compose-build.yml push resourcemanager
	sudo docker-compose -f docker-compose-build.yml push nodemanager
	sudo docker-compose -f docker-compose-build.yml push historyserver
wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal /opt/hadoop-3.1.3/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /input