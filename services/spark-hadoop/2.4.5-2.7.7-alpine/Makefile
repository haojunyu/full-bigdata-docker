DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch = 2.4.5
build:
	sudo docker-compose -f docker-compose-build.yml build --no-cache base-hadoop
	sudo docker-compose -f docker-compose-build.yml build --no-cache master
	sudo docker-compose -f docker-compose-build.yml build --no-cache worker

push:
	sudo docker login dockerhub.datagrand.com
	sudo docker-compose -f docker-compose-build.yml push base-hadoop
	sudo docker-compose -f docker-compose-build.yml push master
	sudo docker-compose -f docker-compose-build.yml push worker
	
deploy:
	docker network create --driver overlay --attachable  hadoop
	docker stack deploy -c hadoop.yml hadoop
	docker stack deploy -c spark.yml spark
	docker run -itd --name submit --network hadoop datagrand/spark-worker:2.4.5-hadoop2.7.7

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal /opt/hadoop-3.1.3/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} datagrand/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
