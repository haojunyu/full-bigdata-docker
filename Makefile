build:
	docker-compose -f docker-compose-build.yml build os-jvm
	docker-compose -f docker-compose-build.yml build zookeeper-official
	docker-compose -f docker-compose-build.yml build kafka-official
	docker-compose -f docker-compose-build.yml build base
	docker-compose -f docker-compose-build.yml build namenode
	docker-compose -f docker-compose-build.yml build datanode
	docker-compose -f docker-compose-build.yml build resourcemanager
	docker-compose -f docker-compose-build.yml build nodemanager
	
bigdata:
	find data/hadoop/ -name ".gitignore" -exec rm {} \;
	sudo docker stack deploy -c bigdata-platform.yml --prune --with-registry-auth bp	

proxyer:
	sudo docker stack rm proxyer	
	sudo docker stack deploy -c proxyer.yml --prune --with-registry-auth proxyer	

clean:
	sudo docker stack rm proxyer
	sudo docker stack rm yskg
	sudo docker stack rm bp

prune:
	find volume/hadoop/ -name ".gitignore" -exec rm {} \;
	sudo rm -r volume/hadoop/namenode/*
	sudo rm -r volume/hadoop/datanode1/*
	sudo rm -r volume/hadoop/datanode2/*
	sudo rm -r volume/hadoop/historyserver/*

network:
	sudo docker network create --driver overlay --attachable bdp

pull:
	sudo docker-compose -f bigdata-platform.yml pull
	sudo docker-compose -f proxyer.yml pull
	sudo docker-compose -f docker-compose.yml pull
