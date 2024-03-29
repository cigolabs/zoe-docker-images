FROM ubuntu:14.04

MAINTAINER Daniele Venzano <venza@brownhat.org>

RUN apt-get update && apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get update && apt-get -y install oracle-java7-installer oracle-java7-set-default curl

ENV SCALA_VERSION 2.10.4
ENV NOTEBOOK_VERSION 0.6.1
ENV SPARK_VERSION 1.5.1
ENV HADOOP_VERSION hadoop-2.5.0-cdh5.3.2

RUN curl -s https://s3.eu-central-1.amazonaws.com/spark-notebook/tgz/spark-notebook-${NOTEBOOK_VERSION}-scala-${SCALA_VERSION}-spark-${SPARK_VERSION}-${HADOOP_VERSION}-with-parquet.tgz | tar -xz -C /opt/

WORKDIR /opt

RUN ln -s spark-notebook-${NOTEBOOK_VERSION}-scala-${SCALA_VERSION}-spark-${SPARK_VERSION}-${HADOOP_VERSION}-with-parquet spark-notebook
ENV PATH /opt/spark-notebook/bin:${PATH}
COPY files/* /opt/
RUN chmod +x /opt/*.sh

EXPOSE 9000 4040

CMD /opt/start-notebook.sh
