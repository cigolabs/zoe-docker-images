#!/bin/bash

set -e
set -x

REPOSITORY=zoerepo

LOCAL_REGISTRY=10.1.0.1:5000

VERSION=""

for d in spark-master spark-worker spark-shell spark-submit spark-jupyter-notebook hadoop-namenode hadoop-datanode; do
#for d in spark-jupyter-notebook; do
  pushd $d
  docker build -t ${REPOSITORY}/$d:${VERSION} .
  if [ z"$1" != z"--build-only" ]; then
    docker tag -f ${REPOSITORY}/$d:${VERSION} ${LOCAL_REGISTRY}/${REPOSITORY}/$d:${VERSION}
    docker push ${LOCAL_REGISTRY}/${REPOSITORY}/$d:${VERSION}
  fi
  popd
done

