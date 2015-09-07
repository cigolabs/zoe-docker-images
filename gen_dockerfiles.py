#!/usr/bin/python3

import os
import shutil

SPARK_VERSION = "1.4.1"
HADOOP_VERSION = "hadoop2.4"

# directory, template file, files
images = [
    ('spark-master', 'master.tmpl'),
    ('spark-worker', 'worker.tmpl'),
    ('spark-shell', 'shell.tmpl'),
    ('spark-shell', 'shell.tmpl'),
    ('spark-submit', 'submit.tmpl')
]

try:
    from jinja2 import Environment, FileSystemLoader
except ImportError:
    print("Jinja2 python module is required to run this script")
    sys.exit(1)

ji_env = Environment(loader=FileSystemLoader('templates'))

common_tmpl = ji_env.get_template('common.tmpl')
common = common_tmpl.render(spark_version=SPARK_VERSION, hadoop_version=HADOOP_VERSION)

for i in images:
    path = i[0]
    tmpl_file = i[1]

    os.makedirs(path, exist_ok=True)
    tmpl = ji_env.get_template(tmpl_file)
    dockerfile = common + "\n" + tmpl.render()
    open(os.path.join(path, "Dockerfile"), "w").write(dockerfile)

