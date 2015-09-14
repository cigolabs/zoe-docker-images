#!/bin/bash

set -e

VERSION=`git branch | grep \* | awk '{ print $2 }'`

if [ ${VERSION} == 'master' ]; then
	VERSION=""
fi

for d in spark-master spark-worker spark-shell spark-submit spark-scala-notebook; do
  pushd $d
  docker build -t $d:${VERSION} .
  popd
done

