#!/bin/bash

set -e

REPOSITORY=zoerepo

LOCAL_REGISTRY=10.1.0.1:5000

for d in spark-master spark-worker spark-shell spark-submit spark-scala-notebook; do
  pushd $d
  docker build -t ${REPOSITORY}/$d:1.2 .
  docker tag ${REPOSITORY}/$d:1.2 ${LOCAL_REGISTRY}/${REPOSITORY}/$d:1.2
  docker push ${LOCAL_REGISTRY}/${REPOSITORY}/$d:1.2
  popd
done

