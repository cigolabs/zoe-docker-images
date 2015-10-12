#!/bin/sh

IMAGE_VER=`git branch | grep \* | awk '{ print $2 }'`
REGISTRY=10.1.0.1:5000
IMAGES="zoerepo/spark-master \
        zoerepo/spark-worker \
        zoerepo/spark-submit \
        zoerepo/spark-shell \
        zoerepo/spark-ipython-notebook \
        zoerepo/spark-scala-notebook \
	zoerepo/hadoop-datanode \
	zoerepo/hadoop-namenode"
SWARM=10.1.0.1:2380

if [ "${IMAGE_VER}" = "master" ]; then
	IMAGE_VER=""
else
	IMAGE_VER=":${IMAGE_VER}"
fi

for i in ${IMAGES}; do
    image=${REGISTRY}/${i}:${IMAGE_VER}
    docker -H ${SWARM} pull ${image}
done

