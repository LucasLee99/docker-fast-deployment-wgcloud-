#!/bin/bash
PROXY_URL= 
MAIN_URL=${PROXY_URL}http://ghproxy.com/https://github.com/LucasLee99/docker-fast-deployment-wgcloud-/blob/main
DOCKER_COMPOSE_URL=${PROXY_URL}https://github.com/LucasLee99/docker-fast-deployment-wgcloud-/blob/main
OFFICAL_SQL_URL=${PROXY_URL}https://github.com/tianshiyeben/wgcloud/blob/master/sql
OFFICAL_BIN=${PROXY_URL}https://github.com/tianshiyeben/wgcloud/blob/master/bin/server
WG_VERSION=$1
function compile_latest(){
	git clone https://github.com/tianshiyeben/wgcloud.git \
	&& cd wgcloud/wgcloud-server \
	&& wget -c https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc6/11.2.0.4/ojdbc6-11.2.0.4.jar \
	&& mv ojdbc6-11.2.0.4.jar ojdbc6.jar \
	&& mvn install:install-file -Dfile=ojdbc6.jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=11.2.0.3 -Dpackaging=jar -DgeneratePom=true \
	&& wget -c https://clojars.org/repo/com/microsoft/sqlserver/sqljdbc4/4.0/sqljdbc4-4.0.jar \
	&& mvn install:install-file -Dfile=sqljdbc4-4.0.jar -DgroupId=com.microsoft.sqlserver -DartifactId=sqljdbc4 -Dversion=4.0 -Dpackaging=jar -DgeneratePom=true \
	&& mvn clean package
}

function download_custom_file(){
  git clone https://github.com/LucasLee99/docker-fast-deployment-wgcloud-.git && mv docker-fast-deployment-wgcloud-/* ./
}

function complie_dockerun(){
	compile_latest
	if [ ! -d wgcloud ];
        then
	  mkdir wgcloud
	fi
	
        mv target/wgcloud-server-release.jar wgcloud/ \
	&& cd wgcloud \
	&& download_custom_file \
	&& wget ${OFFICAL_SQL_URL}/wgcloud.sql \
	&& chmod 777 wgcloud-server-release.jar \
	&& chmod 777 start.sh \
	&& chmod 777 stop.sh \
	&& docker-compose up
}

function release_dockerun(){
   WG_VERSION=$1
   if [ ! -d wgcloud ];
   then
       mkdir wgcloud 
   fi
	cd wgcloud \
	#&& wget -c https://www.wgstart.com/download/${WG_VERSION}/wgcloud-v${WG_VERSION}.tar.gz \
	#&& tar -xzvf wgcloud-v${WG_VERSION}.tar.gz -C ./ \
	#&& cp wgcloud-v${WG_VERSION}/server/wgcloud-server-release.jar ./ \
	wget -c https://github.com/LucasLee99/docker-fast-deployment-wgcloud-/releases/download/3.4.5/wgcloud-server-release.jar \
	&& download_custom_file \
	&& chmod 777 wgcloud-server-release.jar \
	&& chmod 777 start.sh \
	&& chmod 777 stop.sh \
	&& docker-compose up
}

if [ -z $1 ]; then
  echo "编译运行..."
  complie_dockerun
  echo "编译运行结束..."
else
  echo "release 运行..."
  release_dockerun $1
  echo "release 运行结束..."
fi
