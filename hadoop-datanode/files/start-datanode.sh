#!/bin/sh

cd /opt

cat hdfs-site.xml | sed -e "s/XXX_NAMENODE_HOST/$NAMENODE_HOST/" > ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml

${HADOOP_HOME}/bin/hdfs datanode

