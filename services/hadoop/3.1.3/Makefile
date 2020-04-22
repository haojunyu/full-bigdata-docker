DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch = 3.1.3
build:
	sudo docker-compose -f docker-compose-build.yml build base
	sudo docker-compose -f docker-compose-build.yml build namenode
	sudo docker-compose -f docker-compose-build.yml build datanode
	sudo docker-compose -f docker-compose-build.yml build resourcemanager
	sudo docker-compose -f docker-compose-build.yml build nodemanager
	#docker-compose build -t datagrand/hadoop-historyserver:$(current_branch) ./historyserver
	#docker-compose build -t datagrand/hadoop-submit:$(current_branch) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal /opt/hadoop-3.1.3/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /input