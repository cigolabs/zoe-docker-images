#!/bin/sh

SPARK_VER=1.4.1
IMAGE_VER=1.3
REGISTRY=10.1.0.1:5000
IMAGES="$REGISTRY/zoe/spark-master-${SPARK_VER}:${IMAGE_VER} \
       $REGISTRY/zoe/spark-worker-${SPARK_VER}:${IMAGE_VER} \
       $REGISTRY/zoe/spark-submit-${SPARK_VER}:${IMAGE_VER} \
       $REGISTRY/zoe/spark-shell-${SPARK_VER}:${IMAGE_VER} \
       $REGISTRY/zoe/spark-notebook-${SPARK_VER}:${IMAGE_VER}"
SWARM=10.1.0.1:2380

for i in ${IMAGES}; do
    docker -H ${SWARM} pull ${i}
done

