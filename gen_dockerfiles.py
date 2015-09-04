#!/usr/bin/python3

import os
import sys
import shutil

try:
    from jinja2 import Environment, FileSystemLoader
except ImportError:
    print("Jinja2 python module is required to run this script")
    sys.exit(1)

def copyfile(fname, dest):
    if not os.path.exists(os.path.join(dest, 'files')):
        os.makedirs(os.path.join(dest, 'files'), exist_ok=True)
    shutil.copy(os.path.join("files", fname), os.path.join(dest, 'files', fname))

if len(sys.argv) < 4:
    print("Usage: {} <path> <spark version> <hadoop version>".format(sys.argv[0]))
    sys.exit(1)

base_path = sys.argv[1]
if not os.path.exists(base_path):
    print("Output path does not exist")
    sys.exit(1)

ji_env = Environment(loader=FileSystemLoader('templates'))

common_tmpl = ji_env.get_template('common.tmpl')
common = common_tmpl.render(spark_version=sys.argv[2], hadoop_version=sys.argv[3])

# Master
path = os.path.join(base_path, "master")
os.makedirs(path, exist_ok=True)
master_tmpl = ji_env.get_template('master.tmpl')
master = common + "\n" + master_tmpl.render()
open(os.path.join(path, "Dockerfile"), "w").write(master)
for f in ["remove_alias.sh", "start-master.sh"]:
    copyfile(f, path)

# Worker
path = os.path.join(base_path, "worker")
os.makedirs(path, exist_ok=True)
worker_tmpl = ji_env.get_template('worker.tmpl')
worker = common + "\n" + worker_tmpl.render()
open(os.path.join(path, "Dockerfile"), "w").write(worker)
for f in ["remove_alias.sh", "start-worker.sh"]:
    copyfile(f, path)

# Shell
path = os.path.join(base_path, "shell")
os.makedirs(path, exist_ok=True)
shell_tmpl = ji_env.get_template('shell.tmpl')
shell = common + "\n" + shell_tmpl.render()
open(os.path.join(path, "Dockerfile"), "w").write(shell)
for f in ["remove_alias.sh", "start-shell.sh"]:
    copyfile(f, path)

# Submit
path = os.path.join(base_path, "submit")
os.makedirs(path, exist_ok=True)
submit_tmpl = ji_env.get_template('submit.tmpl')
submit = common + "\n" + submit_tmpl.render()
open(os.path.join(path, "Dockerfile"), "w").write(submit)
for f in ["remove_alias.sh", "submit.sh"]:
    copyfile(f, path)

