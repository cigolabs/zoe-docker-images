#!/bin/sh

set -e

SPARK_VER=1.4.1
HADOOP_VER=hadoop2.4
IMAGE_VER=1.2
REGISTRY=10.1.0.1:5000
TAG_BASE=zoe
TEMP_DIR=./temp


mkdir -p ${TEMP_DIR}

./gen_dockerfiles.py ${TEMP_DIR} ${SPARK_VER} ${HADOOP_VER}

for d in master worker shell submit notebook; do
  cd ${TEMP_DIR}/$d
  docker build -t ${REGISTRY}/${TAG_BASE}/spark-$d-${SPARK_VER}:${IMAGE_VER} .
  docker push ${REGISTRY}/${TAG_BASE}/spark-$d-${SPARK_VER}:${IMAGE_VER}
  cd ..
done

rm -Rf ${TEMP_DIR}

