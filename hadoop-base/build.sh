#!/bin/bash 
set -euo pipefail

NAME=nberserk/armhf-hadoop-base 
docker build -t $NAME .
docker push $NAME



