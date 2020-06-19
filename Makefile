build:
	docker-compose -f docker-compose-build.yml build os-jvm
	docker-compose -f docker-compose-build.yml build zookeeper-official
	docker-compose -f docker-compose-build.yml build kafka-official
	docker-compose -f docker-compose-build.yml build base
	docker-compose -f docker-compose-build.yml build namenode
	docker-compose -f docker-compose-build.yml build datanode
	docker-compose -f docker-compose-build.yml build resourcemanager
	docker-compose -f docker-compose-build.yml build nodemanager

build_hadoop:
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine -f services/os-jvm/alpine-openjdk8/Dockerfile services/os-jvm/alpine-openjdk8/
	#sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/openjdk:8-jdk-alpine -f services/os-jvm/alpine-openjdk8/Dockerfile services/os-jvm/alpine-openjdk8/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hadoop-base:2.7.7-alpine -f services/hadoop/2.7.7-alpine/base/Dockerfile services/hadoop/2.7.7-alpine/base/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hadoop-namenode:2.7.7-alpine -f services/hadoop/2.7.7-alpine/namenode/Dockerfile services/hadoop/2.7.7-alpine/namenode/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hadoop-datanode:2.7.7-alpine -f services/hadoop/2.7.7-alpine/datanode/Dockerfile services/hadoop/2.7.7-alpine/datanode/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hadoop-historyserver:2.7.7-alpine -f services/hadoop/2.7.7-alpine/historyserver/Dockerfile services/hadoop/2.7.7-alpine/historyserver/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hadoop-nodemanager:2.7.7-alpine -f services/hadoop/2.7.7-alpine/nodemanager/Dockerfile services/hadoop/2.7.7-alpine/nodemanager/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hadoop-resourcemanager:2.7.7-alpine -f services/hadoop/2.7.7-alpine/resourcemanager/Dockerfile services/hadoop/2.7.7-alpine/resourcemanager/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hadoop-all:2.7.7-alpine -f services/hadoop/2.7.7-alpine/baseall/Dockerfile services/hadoop/2.7.7-alpine/baseall/

build_spark:
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/spark-base:2.4.5-hadoop2.7.7-alpine -f services/spark-hadoop/2.4.5-2.7.7-alpine/base-hadoop/Dockerfile services/spark-hadoop/2.4.5-2.7.7-alpine/base-hadoop/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/spark-master:2.4.5-hadoop2.7.7-alpine -f services/spark-hadoop/2.4.5-2.7.7-alpine/master/Dockerfile services/spark-hadoop/2.4.5-2.7.7-alpine/master/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/spark-worker:2.4.5-hadoop2.7.7-alpine -f services/spark-hadoop/2.4.5-2.7.7-alpine/worker/Dockerfile services/spark-hadoop/2.4.5-2.7.7-alpine/worker/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/spark-all:2.4.5-hadoop2.7.7-alpine -f services/spark-hadoop/2.4.5-2.7.7-alpine/baseall/Dockerfile services/spark-hadoop/2.4.5-2.7.7-alpine/baseall/


build_hbase:
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hbase-base:2.1.10-alpine -f services/hbase/2.1.10-alpine/base/Dockerfile services/hbase/2.1.10-alpine/base/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hbase-hmaster:2.1.10-alpine -f services/hbase/2.1.10-alpine/hmaster/Dockerfile services/hbase/2.1.10-alpine/hmaster
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hbase-hregionserver:2.1.10-alpine -f services/hbase/2.1.10-alpine/hregionserver/Dockerfile services/hbase/2.1.10-alpine/hregionserver/
	sudo docker build --no-cache -t dockerhub.datagrand.com/yskg/hbase-all:2.1.10-alpine -f services/hbase/2.1.10-alpine/baseall/Dockerfile services/hbase/2.1.10-alpine/baseall/
	


	
bigdata:
	find volume/hadoop/ -name ".gitignore" -exec rm {} \;
	sudo docker stack deploy -c bigdata-platform.yml --prune --with-registry-auth bdp	
	#sudo docker stack deploy -c hadoop.yml --prune --with-registry-auth hd	
	#sudo docker stack deploy -c spark.yml --prune --with-registry-auth sp	
	#sudo docker stack deploy -c hbase.yml --prune --with-registry-auth hb	

test_bp:
	echo "hdfs status: "`curl -I -m 10 -o /dev/null -s -w %{http_code} localhost:50070`
	echo "yarn status: "`curl -I -m 10 -o /dev/null -s -w %{http_code} localhost:8088`
	echo "history status: "`curl -I -m 10 -o /dev/null -s -w %{http_code} localhost:8188`
	echo "spark status: "`curl -I -m 10 -o /dev/null -s -w %{http_code} localhost:8080`
	echo "hmaster status: "`curl -I -m 10 -o /dev/null -s -w %{http_code} localhost:16010`
	echo "hregion1 status: "`curl -I -m 10 -o /dev/null -s -w %{http_code} localhost:16031`
	echo "hregion2 status: "`curl -I -m 10 -o /dev/null -s -w %{http_code} localhost:16032`

proxyer:
	sudo docker stack rm proxy	
	sudo docker stack deploy -c proxyer.yml --prune --with-registry-auth proxy	

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
	sudo docker push dockerhub.datagrand.com/yskg/hadoop-all:2.7.7-alpine
	sudo docker push dockerhub.datagrand.com/yskg/spark-all:2.4.5-hadoop2.7.7-alpine
	sudo docker push dockerhub.datagrand.com/yskg/hbase-all:2.1.10-alpine

push:
	sudo docker push dockerhub.datagrand.com/yskg/openjdk:8-jre-alpine
	sudo docker push dockerhub.datagrand.com/yskg/hadoop-all:2.7.7-alpine
	sudo docker push dockerhub.datagrand.com/yskg/spark-all:2.4.5-hadoop2.7.7-alpine
	sudo docker push dockerhub.datagrand.com/yskg/hbase-all:2.1.10-alpine

