from armv7/armhf-ubuntu_core:15.10

# to run on x86
COPY cross-build-tools/ /usr/bin
RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y openjdk-7-jdk openssh-server openssh-client rsync vim curl

# install daemontools for svscan  
RUN wget http://ftp.cn.debian.org/debian/pool/main/d/daemontools/daemontools_0.76-6_armhf.deb && dpkg -i daemontools_0.76-6_armhf.deb

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-armhf
ENV HADOOP_PREFIX /usr/local/hadoop
ENV PATH $PATH:$JAVA_HOME/bin

# sshd setting
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -P ''
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
ADD config /root/.ssh/
RUN chmod 600 /root/.ssh/config
#RUN chown root:root /root/.ssh/config  
RUN echo 'root:sheepdog' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config


# install hadoop 
COPY hadoop-2.7.1.tar.gz /usr/local
RUN tar -xvzf /usr/local/hadoop-2.7.1.tar.gz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.7.1 hadoop && rm -rf /usr/local/hadoop/lib/native
RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-armhf\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

ADD bashrc /root/.bashrc

EXPOSE 2122











