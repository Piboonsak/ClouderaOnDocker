#!/bin/bash
## Create mysql 5.7.23

docker run -dt --name cdhDB \
--network cloudera --hostname cdhDB \
--ip 177.10.10.206 \
-p 20222:22 -p 53306:3306 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/mysql:/etc/mysql \
-v cdhDB:/var/lib/mysql \
piboonsak/ubuntu:mysqlv5.7.23
