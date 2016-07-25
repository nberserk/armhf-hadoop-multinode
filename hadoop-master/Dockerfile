from 10.240.70.80:5000/armhf-hadoop-base

MAINTAINER Darren Ha

ENV HADOOP_INSTALL /usr/local/hadoop

# sshd
RUN mkdir -p /etc/service/sshd
ADD service /etc/service
RUN chmod +x /etc/service/sshd/run

ADD hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml 
ADD core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml 
ADD mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml 
ADD yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml 
ADD slaves $HADOOP_PREFIX/etc/hadoop/slaves

RUN mkdir -p $HADOOP_PREFIX/logs
#RUN chown -R hduser:hadoop $HADOOP_PREFIX/logs

# Format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

#ADD start-hadoop.sh $HADOOP_PREFIX/bin/start-hadoop.sh
ADD bootstrap.sh /root/bootstrap.sh

EXPOSE 2122

# HDFS ports
EXPOSE 9000 50010 50020 50070 50075 50090 50475

# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8042 8060 8088 50060

#RUN cross-build-end

CMD ["bin/bash", "/root/bootstrap.sh"]
