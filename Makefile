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
