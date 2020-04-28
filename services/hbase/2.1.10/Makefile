DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch = 2.1.10
PROJECT_PREFIX = dockerhub.datagrand.com/yskg
build:
	sudo docker-compose -f docker-compose-build.yml build base
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml build standalone
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml build hmaster
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml build hregionserver

standalone:
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker stack deploy -c docker-compose-standalone.yml hbase

distributed:
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker stack deploy -c docker-compose.yml hbase