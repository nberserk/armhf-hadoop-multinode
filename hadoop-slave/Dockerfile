from 10.240.70.80:5000/armhf-hadoop-base

MAINTAINER Darren Ha

# svscan 
# RUN mkdir -p /etc/service/sshd
# ADD service /etc/service
# RUN chmod +x /etc/service/sshd/run

ADD hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml 
ADD core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml 
ADD mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml 
ADD yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml 

ADD bootstrap.sh /root/bootstrap.sh


RUN mkdir -p $HADOOP_PREFIX/logs

EXPOSE 2122

# HDFS ports
EXPOSE 9000 50010 50020 50070 50075 50090 50475

# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8042 8060 8088 50060

#RUN cross-build-end

#CMD ["/usr/bin/svscan", "/etc/service/"]
CMD ["/bin/bash", "/root/bootstrap.sh"]







