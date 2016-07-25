#!/bin/bash
set -euo pipefail

# echo "replacing master ip with $MASTER"
sed -i "s/HOSTNAME/$MASTER/" /usr/local/hadoop/etc/hadoop/core-site.xml

FILE=/root/replaced
if [ -f $FILE ];
then
    echo "skipping replace"
else
    # add slaves
    IFS=',' read -r -a array <<< "$SLAVES"
    for i in "${array[@]}"
    do
	echo "$i" >> /usr/local/hadoop/etc/hadoop/slaves
    done
    touch $FILE
fi

echo "Starting sshd"
exec /usr/sbin/sshd -D &

cat /usr/local/hadoop/etc/hadoop/slaves

$HADOOP_INSTALL/sbin/start-dfs.sh
#$HADOOP_INSTALL/sbin/start-yarn.sh

if [ -z "$1" ];
then
    tail -f $HADOOP_INSTALL/logs/*
fi


