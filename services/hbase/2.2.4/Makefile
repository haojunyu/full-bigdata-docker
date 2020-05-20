DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
PROJECT_PREFIX = dockerhub.datagrand.com/yskg
build:
	sudo docker-compose -f docker-compose-build.yml build --no-cache base
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml build --no-cache standalone
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml build --no-cache hmaster
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml build --no-cache hregionserver

push:
	sudo docker login dockerhub.datagrand.com
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml push standalone
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml push hmaster
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker-compose -f docker-compose-build.yml push hregionserver

standalone:
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker stack deploy -c docker-compose-standalone.yml hbase

distributed:
	sudo PROJECT_PREFIX=${PROJECT_PREFIX} docker stack deploy -c docker-compose.yml hbase
