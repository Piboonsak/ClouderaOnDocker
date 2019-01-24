#!/bin/bash
## Don't mount secret key.

## hd-c1nn
docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2022:22 -p 2225:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1nn complete!"

## hd-c2nn

ssh docker101 \
docker run -dt --name hd-c2nn \
--network cloudera --hostname hd-c2nn \
--ip 177.10.10.11 \
-p 2022:22 -p 2225:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c2nn complete!"

## hd-c1dn1

ssh docker102 \
docker run -dt --name hd-c1dn1 \
--network cloudera --hostname hd-c1dn1 \
--ip 177.10.10.12 \
-p 2022:22 -p 2225:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn1 complete!"

## hd-c1dn2

ssh docker105 \
docker run -dt --name hd-c1dn2 \
--network cloudera --hostname hd-c1dn2 \
--ip 177.10.10.13 \
-p 2022:22 -p 2225:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn2 complete!"

## hd-c1dn3

ssh docker106 \
docker run -dt --name hd-c1dn3 \
--network cloudera --hostname hd-c1dn3 \
--ip 177.10.10.14 \
-p 2022:22 -p 2025:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn3 complete!"

## hd-c1dn4

ssh docker107 \
docker run -dt --name hd-c1dn4 \
--network cloudera --hostname hd-c1dn4 \
--ip 177.10.10.15 \
-p 2022:22 -p 2025:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn4 complete!"
echo "Create clodera hosts complete!"
