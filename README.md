# zoe-docker-images

This repository contains the scripts and configuration files used to create images for Zoe, the Container
Analytics as a Service.

Currently these images can be created:

* Spark master
* Spark worker
* Spark submit
* Spark shell
* Spark Scala notebook

Look at the README files in each image directory for more details.

## Useful scripts

To run use the `build_images.sh` script. Customize the variables at the top of the script to set paths and addresses.

The `swarm_pull.sh` script pulls the images in a Swarm cluster, for faster container startup.

The Python script (Python 3) is used by `build_images.sh` and requires `jinja2`.

