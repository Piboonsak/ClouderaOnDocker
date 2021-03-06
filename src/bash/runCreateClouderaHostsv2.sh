#!/bin/bash
## Don't mount secret key.

## hd-c1nn
docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v4

echo "Create host hd-c1nn complete!"

## hd-c2nn

ssh docker101 \
docker run -dt --name hd-c2nn \
--network cloudera --hostname hd-c2nn \
--ip 177.10.10.11 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v4

echo "Create host hd-c2nn complete!"

## hd-c1dn1

ssh docker102 \
docker run -dt --name hd-c1dn1 \
--network cloudera --hostname hd-c1dn1 \
--ip 177.10.10.12 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v4

echo "Create host hd-c1dn1 complete!"

## hd-c1dn2

ssh docker105 \
docker run -dt --name hd-c1dn2 \
--network cloudera --hostname hd-c1dn2 \
--ip 177.10.10.13 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v4

echo "Create host hd-c1dn2 complete!"

## hd-c1dn3

ssh docker106 \
docker run -dt --name hd-c1dn3 \
--network cloudera --hostname hd-c1dn3 \
--ip 177.10.10.14 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v4

echo "Create host hd-c1dn3 complete!"

## hd-c1dn4

ssh docker107 \
docker run -dt --name hd-c1dn4 \
--network cloudera --hostname hd-c1dn4 \
--ip 177.10.10.15 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v4

echo "Create host hd-c1dn4 complete!"
echo "Create clodera hosts complete!"
