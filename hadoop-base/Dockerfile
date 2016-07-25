from armv7/armhf-ubuntu_core:15.10

# to run on x86
COPY cross-build-tools/ /usr/bin
RUN [ "cross-build-start" ]

#ENV http_proxy http://168.219.61.252:8080

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server openssh-client vim curl && apt-get clean

# install daemontools for svscan  
#RUN wget http://ftp.cn.debian.org/debian/pool/main/d/daemontools/daemontools_0.76-6_armhf.deb && dpkg -i daemontools_0.76-6_armhf.deb

ENV HADOOP_PREFIX /usr/local/hadoop

# sshd setting
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -P '' &&  cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
ADD config /root/.ssh/
RUN chmod 600 /root/.ssh/config
#RUN chown root:root /root/.ssh/config  
RUN echo 'root:sheepdog' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && echo "Port 2122" >> /etc/ssh/sshd_config

# install sun jdk7
RUN mkdir -p /usr/local/java && curl -L 'http://download.oracle.com/otn-pub/java/jdk/7u60-b19/jdk-7u60-linux-arm-vfp-hflt.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie' --insecure | tar -xz -C /usr/local/java/

ENV JAVA_HOME /usr/local/java/jdk1.7.0_60
ENV PATH $JAVA_HOME/bin:$PATH

# install hadoop 
RUN curl -s http://mirror.apache-kr.org/hadoop/common/hadoop-2.6.2/hadoop-2.6.2.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.6.2 hadoop && rm -rf /usr/local/hadoop/lib/native
RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/java/jdk1.7.0_60\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
#ADD native.tar.gz /usr/local # jvm crash
RUN chown -R root:root /usr/local/hadoop-2.6.2 
ADD bashrc /root/.bashrc

# install spark
#RUN curl -s -L http://apache.mirror.cdnetworks.com/spark/spark-1.6.2/spark-1.6.2-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN curl -s -L http://archive.apache.org/dist/spark/spark-1.3.0/spark-1.3.0-bin-hadoop2.4.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./spark-1.3.0-bin-hadoop2.4 spark

# readelf for spark snappy codec
ADD readelf /usr/bin/readelf

EXPOSE 2122
