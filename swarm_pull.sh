#!/bin/sh

#IMAGE_VER=1.3
REGISTRY=10.1.0.1:5000
IMAGES="zoerepo/spark-master \
        zoerepo/spark-worker \
        zoerepo/spark-submit \
        zoerepo/spark-shell \
        zoerepo/spark-notebook"
SWARM=10.1.0.1:2380

for i in ${IMAGES}; do
    if [ -n "${IMAGE_VER}" ]; then
        image=${i}:${IMAGE_VER}
    else
        image="${i}"
    fi
    docker -H ${SWARM} pull ${image}
done

