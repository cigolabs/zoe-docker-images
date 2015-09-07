# Spark Shell image

This image contains Spark and a script to run the Spark shell. It is part of Zoe, the Container Analytics as a
Service system. This image is not currently used, but it can be of help when debugging a containerized Spark,
or when running clusters by hand.

Zoe can be found at: https://github.com/DistributedSystemsGroup/zoe

## Setup

The Dockerfile runs the shell at startup, configurationcan be passed using these environment variables:

* SPARK\_MASTER\_IP: IP address of the Spark master this shell should use
* SPARK\_EXECUTOR\_RAM: How much RAM to use for each executor

