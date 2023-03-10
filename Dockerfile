FROM openjdk:8-jdk-alpine
ENV LANG C.UTF-8
MAINTAINER "Frank Li"
LABEL description="wg-cloud server"

RUN mkdir -p /wgcloud/bin /wgcloud/config
VOLUME /etc/wgcloud /wgcloud/config
WORKDIR wgcloud 
COPY wgcloud-server-release.jar bin/wgcloud-server-release.jar
COPY start.sh bin/start.sh
COPY stop.sh bin/stop.sh
COPY wgcloud.sql bin/wgcloud.sql

EXPOSE 9999
ENTRYPOINT ["java","-jar","bin/wgcloud-server-release.jar"]
