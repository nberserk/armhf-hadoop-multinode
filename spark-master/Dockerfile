from 10.240.70.80:5000/armhf-hadoop-master

MAINTAINER Darren Ha<darren.ha@samsung.com>

ENV SPARK_HOME /usr/local/spark
ADD conf $SPARK_HOME/conf
ADD spark-bootstrap.sh /root/spark-bootstrap.sh

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006

RUN ["cross-build-end"]
CMD ["/bin/bash", "/root/spark-bootstrap.sh"]
