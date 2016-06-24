#!/bin/bash

/usr/bin/svscan /etc/service/ &
sleep 4


# add slaves
IFS=',' read -r -a array <<< "$SLAVES"
for i in "${array[@]}"
do
    echo "$i" >> /usr/local/hadoop/etc/hadoop/slaves
done

cat /usr/local/hadoop/etc/hadoop/slaves


#if [ "$NODE_TYPE" = "m" ]; then
   $HADOOP_INSTALL/sbin/start-dfs.sh
   #su hduser -c "$HADOOP_INSTALL/sbin/start-yarn.sh"
#fi
tail -f $HADOOP_INSTALL/logs/*
