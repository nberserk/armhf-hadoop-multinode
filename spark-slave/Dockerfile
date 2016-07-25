from 10.240.70.80:5000/armhf-hadoop-slave

MAINTAINER Darren Ha<darren.ha@samsung.com>

# spark
# RUN wget http://mirror.apache-kr.org/spark/spark-1.6.2/spark-1.6.2-bin-hadoop2.6.tgz && tar xvzf spark-1.6.2-bin-hadoop2.6.tgz -C /usr/local
# RUN cd /usr/local && ln -s ./spark-1.6.2-bin-hadoop2.6 spark

ENV SPARK_HOME /usr/local/spark
ADD conf $SPARK_HOME/conf


EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006

RUN [ "cross-build-end" ]
CMD ["/bin/bash", "/root/bootstrap.sh"]
