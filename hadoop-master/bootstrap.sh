#!/bin/bash
set -euo pipefail

# echo "replacing master ip with $MASTER"
sed -i "s/HOSTNAME/$MASTER/" /usr/local/hadoop/etc/hadoop/core-site.xml

echo "Starting sshd"
exec /usr/sbin/sshd -D &

# add slaves
IFS=',' read -r -a array <<< "$SLAVES"
for i in "${array[@]}"
do
    echo "$i" >> /usr/local/hadoop/etc/hadoop/slaves
done

cat /usr/local/hadoop/etc/hadoop/slaves

$HADOOP_INSTALL/sbin/start-dfs.sh
$HADOOP_INSTALL/sbin/start-yarn.sh
tail -f $HADOOP_INSTALL/logs/*
