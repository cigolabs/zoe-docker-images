#!/bin/sh

cd /opt

cat core-site.xml | sed -e "s/XXX_NAMENODE_HOST/$NAMENODE_HOST/" > ${HADOOP_HOME}/etc/hadoop/core-site.xml
cp hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/

${HADOOP_HOME}/bin/hdfs datanode

