#!/bin/bash


echo $HOSTNAME 
docker container ls -a | egrep hd-
docker container ls -a | egrep db-

echo "docker101"
ssh docker101 docker container ls -a | egrep hd-

echo "docker102"
ssh docker102 docker container ls -a | egrep hd-

echo "docker105"
ssh docker105 docker container ls -a | egrep hd-

echo "docker106"
ssh docker106 docker container ls -a | egrep hd-

echo "docker107"
ssh docker107 docker container ls -a | egrep hd-

echo "List cloudera container all hosts."
