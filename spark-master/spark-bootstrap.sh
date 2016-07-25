#!/bin/bash
set -euo pipefail

/root/bootstrap.sh no_tail

FILE=$SPARK_HOME/conf/slaves
if [ -f $FILE ]; then
    echo "skipping injecting slaves"
else
    # add slaves
    touch $FILE
    IFS=',' read -r -a array <<< "$SLAVES"
    for i in "${array[@]}"
    do
	echo "$i" >> $FILE
    done    
fi

$SPARK_HOME/sbin/start-all.sh
tail -f $SPARK_HOME/logs/*
