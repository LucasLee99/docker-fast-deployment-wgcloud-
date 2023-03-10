#!/bin/bash
MAIN_URL="http://ghproxy.com/https://github.com/LucasLee99/docker-fast-deployment-wgcloud-/blob/main/"
mkdir wgcloud && cd wgcloud \
&& wget ${MAIN_URL}/docker-compose.yaml  \
&& wget ${MAIN_URL}/Dockerfile  mysql \
&& wget ${MAIN_URL}/start.sh  \
&& wget  ${MAIN_URL}/stop.sh  \
&& wget ${MAIN_URL}/wgcloud-server-release.jar  \
&& wget ${MAIN_URL}/wgcloud.sql

chmod 777 wgcloud-server-release.jar
chmod 777 start.sh
chmod 777 stop.sh

docker-compose up
