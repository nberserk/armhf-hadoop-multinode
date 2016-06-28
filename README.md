# Hadoop Multinode cluster Docker for ARM 
There are no Hadoop docker images for ARM architecture. so I created one. inspired by [hadoop-multinode](https://github.com/alvinhenrick/hadoop-mutinode). But do not use serf and dns servers to simplify the process.


Build Hadoop Cluster
-----------------------------

## run hadoop-slave

```
docker run --rm -d -e MASTER=<master_ip> -h slave1 --name=s1 -p 2122:2122 -p 9000:9000 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 50090:50090 -p 50475:50475 nberserk/armhf-hadoop-slave
```

## run hadoop-master

```
docker run --rm -d -e MASTER=<master ip> -e SLAVES=<slave1 ip>,<slave2 ip> --name master --net=host nberserk/armhf-hadoop-master
```

## check

open http://<master_ip>:50070 in your web browser.
