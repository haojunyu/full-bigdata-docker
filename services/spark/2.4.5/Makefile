DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch = 2.4.5
build:
	sudo docker-compose -f docker-compose-build.yml build base
	sudo docker-compose -f docker-compose-build.yml build master
	sudo docker-compose -f docker-compose-build.yml build worker

deploy:
	docker stack deploy -c docker-compose.yml spark

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal /opt/hadoop-3.1.3/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /input