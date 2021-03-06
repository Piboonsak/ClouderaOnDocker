#!/bin/bash
## Not mount secret key.

# Create hadoop data dir

mkdir -p /hadoop
chmod 766 /hadoop

ssh hd-c2nn mkdir -p /hadoop
ssh hd-c2nn chmod 766 /hadoop

ssh hd-c1dn1 mkdir -p /hadoop
ssh hd-c1dn1 chmod 766 /hadoop

ssh hd-c1dn2 mkdir -p /hadoop
ssh hd-c1dn2 chmod 766 /hadoop

ssh hd-c1dn3 mkdir -p /hadoop
ssh hd-c1dn3 chmod 766 /hadoop

ssh hd-c1dn4 mkdir -p /hadoop
ssh hd-c1dn4 chmod 766 /hadoop

## hd-c1nn
docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /hadoop:/hadoop \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1nn complete!"


## hd-c2nn

ssh docker101 \
docker run -dt --name hd-c2nn \
--network cloudera --hostname hd-c2nn \
--ip 177.10.10.11 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /hadoop:/hadoop \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c2nn complete!"


## hd-c1dn1

ssh docker102 \
docker run -dt --name hd-c1dn1 \
--network cloudera --hostname hd-c1dn1 \
--ip 177.10.10.12 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /hadoop:/hadoop \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn1 complete!"


## hd-c1dn2

ssh docker105 \
docker run -dt --name hd-c1dn2 \
--network cloudera --hostname hd-c1dn2 \
--ip 177.10.10.13 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /hadoop:/hadoop \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn2 complete!"


## hd-c1dn3

ssh docker106 \
docker run -dt --name hd-c1dn3 \
--network cloudera --hostname hd-c1dn3 \
--ip 177.10.10.14 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /hadoop:/hadoop \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn3 complete!"


## hd-c1dn4

ssh docker107 \
docker run -dt --name hd-c1dn4 \
--network cloudera --hostname hd-c1dn4 \
--ip 177.10.10.15 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /hadoop:/hadoop \
piboonsak/ubuntu:STD_16.04v5

echo "Create host hd-c1dn4 complete!"
echo "Create clodera hosts v4 complete!"
