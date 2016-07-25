#!/bin/bash 
set -euo pipefail

NAME=10.240.70.80:5000/armhf-hadoop-base 
docker build --build-arg http_proxy=http://168.219.61.252:8080 --build-arg https_proxy=http://168.219.61.252:8080 -t $NAME .
#docker push $NAME
