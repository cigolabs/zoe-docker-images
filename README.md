# zoe-docker-images

Scripts for building Docker images containing Spark, for use with Zoe, the Container Analytics as a Service.

These scripts create the following images and upload them to a private docker registry:

* Spark master
* Spark worker
* Spark submit
* Spark shell
* Spark Scala Notebook (https://github.com/andypetrella/spark-notebook)

To run use the `build_images.sh` script. Customize the variables at the top of the script to set paths and addresses.

The `swarm_pull.sh` script pulls the images in a Swarm cluster, for faster container startup.

The Python script (Python 3) is used by `build_images.sh` and requires `jinja2`.

