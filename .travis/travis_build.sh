#!/bin/bash

set -e
set -x

for d in spark-master spark-worker spark-shell spark-submit spark-scala-notebook; do
  pushd $d
  docker build .
  popd
done

