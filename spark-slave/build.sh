#!/bin/bash 
set -euo pipefail

PREFIX=10.240.70.80:5000/armhf-spark-slave
VER=`cat ../VERSION`

ID=$PREFIX:$VER
docker build --no-cache -t $ID .
#docker push $ID

ID_LATEST=$PREFIX:latest
docker tag $ID $ID_LATEST
#docker push $ID_LATEST
