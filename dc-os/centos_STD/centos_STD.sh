#!/bin/bash
docker run -dt \
 --name=centos \
 --hostname centos \
 --privileged \
 -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
wathit/centos:v1
