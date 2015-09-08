#!/bin/bash

set -e

REPOSITORY=zoerepo

LOCAL_REGISTRY=10.1.0.1:5000

for d in spark-master spark-worker spark-shell spark-submit spark-scala-notebook; do
  pushd $d
  docker build -t ${REPOSITORY}/$d .
  docker tag ${REPOSITORY}/$d ${LOCAL_REGISTRY}/${REPOSITORY}/$d
  docker push ${LOCAL_REGISTRY}/${REPOSITORY}/$d
  popd
done

