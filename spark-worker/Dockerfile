# This dockerfile is generated, do not edit

FROM ubuntu:14.04

MAINTAINER Daniele Venzano <venza@brownhat.org>

RUN apt-get update && apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get update && apt-get -y install oracle-java7-installer oracle-java7-set-default curl

ENV SPARK_VERSION 1.5.1
ENV HADOOP_VERSION hadoop2.6

RUN curl -s http://mirrors.ircam.fr/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz | tar -xz -C /opt/

WORKDIR /opt

RUN ln -s spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} spark
ENV SPARK_HOME /opt/spark
ENV PATH /opt/spark/bin:/opt/spark/sbin:${PATH}

COPY files/* /opt/
RUN chmod +x /opt/*.sh
RUN apt-get update && apt-get -y install python3 python3-numpy

ENV NB_USER bnuser
ENV NB_UID 1000

# Create nbuser user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

EXPOSE 8888 8081 4040

CMD /opt/start-worker.sh

#ENV SPARK_WORKER_PORT 8888
#ENV SPARK_WORKER_WEBUI_PORT 8081