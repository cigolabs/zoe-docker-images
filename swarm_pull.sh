#!/bin/sh

IMAGE_VER=1.2
REGISTRY="10.1.0.1:5000"  # Set this to empty to use Docker Hub

IMAGES="zoerepo/spark-master \
        zoerepo/spark-worker \
        zoerepo/spark-submit \
        zoerepo/spark-shell \
        zoerepo/spark-scala-notebook"
SWARM=10.1.0.1:2380

for i in ${IMAGES}; do
    if [ -n "${IMAGE_VER}" ]; then
        image=${REGISTRY}/${i}:${IMAGE_VER}
    else
        image=${REGISTRY}/${i}
    fi
    docker -H ${SWARM} pull ${image}
done

