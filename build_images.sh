#!/bin/bash

set -e

REPOSITORY=zoerepo

LOCAL_REGISTRY=10.1.0.1:5000

VERSION=`git branch | grep \* | awk '{ print $2 }'`

if [ ${VERSION} == 'master' ]; then
	VERSION=""
fi

for d in spark-master spark-worker spark-shell spark-submit spark-scala-notebook; do
  pushd $d
  docker build -t ${REPOSITORY}/$d:${VERSION} .
  docker tag ${REPOSITORY}/$d:${VERSION} ${LOCAL_REGISTRY}/${REPOSITORY}/$d:${VERSION}
  docker push ${LOCAL_REGISTRY}/${REPOSITORY}/$d:${VERSION}
  popd
done

