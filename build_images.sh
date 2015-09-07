#!/bin/bash

set -e

REPOSITORY=zoerepo

for d in spark-master spark-worker spark-shell spark-submit spark-scala-notebook; do
  pushd $d
  docker build -t ${REPOSITORY}/$d .
  popd
done

