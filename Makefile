build:
	docker-compose -f docker-compose-build.yml build os-jvm
	docker-compose -f docker-compose-build.yml build zookeeper-official
	docker-compose -f docker-compose-build.yml build kafka-official
network:
	docker network create --driver overlay --attachable --subnet 13.14.15.0/24 --ip-range 13.14.15.0/24 --gateway 13.14.15.1 bigdata

clean:
	# 检查网络bigdata是否创建，并清理
	echo "xxx"