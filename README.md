# Hadoop Multinode cluster Docker for ARM 
There are no Hadoop docker images for ARM architecture. so I created one. inspired by [hadoop-multinode](https://github.com/alvinhenrick/hadoop-mutinode). But do not use serf and dns servers to simplify the process.


Build Hadoop Cluster
-----------------------------

* run hadoop-slave
 * Run `docker run --rm nberserk/armhf-hadoop-slave`
* run hadoop-master
 * Run `docker run --rm --net=host nberserk/armhf-hadoop-master`

