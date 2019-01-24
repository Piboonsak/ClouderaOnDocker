#!/bin/bash
## Not mount secret key.

## Docker node defind
C1NNHOST="$(ssh docker100 'echo $HOSTNAME')"
C2NNHOST="$(ssh docker101 'echo $HOSTNAME')"
C1DN1HOST="$(ssh docker102 'echo $HOSTNAME')"
C1DN2HOST="$(ssh docker105 'echo $HOSTNAME')"
C1DN3HOST="$(ssh docker106 'echo $HOSTNAME')"
C1DN4HOST="$(ssh docker107 'echo $HOSTNAME')"

## Cloudera host defind
C1NN=$(echo "hd-c1nn")
C2NN=$(echo "hd-c2nn")
C1DN1=$(echo "hd-c1dn1")
C1DN2=$(echo "hd-c1dn2")
C1DN3=$(echo "hd-c1dn3")
C1DN4=$(echo "hd-c1dn4")

## Network defind
NETWORK=$(echo "cloudera")


# Create hadoop data dir
mkdir -p /hadoop
chmod 777 /hadoop

ssh ${C2NNHOST} mkdir -p /hadoop
ssh ${C2NNHOST} chmod 777 /hadoop
ssh ${C2NNHOST} ls -alh /hadoop

ssh ${C1DN1HOST} mkdir -p /hadoop
ssh ${C1DN1HOST} chmod 777 /hadoop
ssh ${C1DN1HOST} ls -alh /hadoop

ssh ${C1DN2HOST} mkdir -p /hadoop
ssh ${C1DN2HOST} chmod 777 /hadoop
ssh ${C1DN2HOST} ls -alh /hadoop

ssh ${C1DN3HOST} mkdir -p /hadoop
ssh ${C1DN3HOST} chmod 777 /hadoop
ssh ${C1DN3HOST} ls -alh /hadoop

ssh ${C1DN4HOST} mkdir -p /hadoop
ssh ${C1DN4HOST} chmod 777 /hadoop
ssh ${C1DN4HOST} ls -alh /hadoop
echo "------------------------------Create path hadoop completed!!!--------------------------------"

## hd-c1nn
docker run -dt --name ${C1NN} \
--network ${NETWORK} --hostname ${C1NN} \
--ip 177.10.10.10 \
-p 2022:22 -p 81:80 -p 88:88 -p 4443:443 -p 8020:8020 -p 8022:8022 -p 8032:8032 \
-p 8033:8033 -p 8080:8080 -p 8088:8088  -p 8888:8888  \
-p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 10000:10000 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 50020:50020 -p 50070:50070 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
-v /root/ClouderaOnDocker/src/cloudera-manager-installer.bin:/root/cloudera-manager-installer.bin \
-v /root/ClouderaOnDocker/src/bash/secret/createAuthorizedKey.sh:/root/createAuthorizedKey.sh \
piboonsak/ubuntu:cloudera
echo "Create host hd-c1nn complete!"


## hd-c2nn
ssh ${C2NNHOST} \
docker run -dt --name ${C2NN} \
--network ${NETWORK} --hostname ${C2NN} \
--ip 177.10.10.11 \
-p 2022:22 -p 81:80 -p 88:88 -p 4443:443 -p 8020:8020 -p 8022:8022 -p 8032:8032 \
-p 8033:8033 -p 8080:8080 -p 8088:8088  -p 8888:8888  \
-p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 10000:10000 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 50020:50020 -p 50070:50070 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:cloudera
echo "Create host hd-c2nn complete!"


## hd-c1dn1
ssh ${C1DN1HOST} \
docker run -dt --name ${C1DN1} \
--network ${NETWORK} --hostname ${C1DN1} \
--ip 177.10.10.12 \
-p 2022:22 -p 81:80 -p 88:88 -p 4443:443 -p 8020:8020 -p 8022:8022 -p 8032:8032 \
-p 8033:8033 -p 8080:8080 -p 8088:8088  -p 8888:8888  \
-p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 10000:10000 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 50020:50020 -p 50070:50070 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:cloudera
echo "Create host hd-c1dn1 complete!"


## hd-c1dn2
ssh ${C1DN2HOST} \
docker run -dt --name ${C1DN2} \
--network ${NETWORK} --hostname  ${C1DN2} \
--ip 177.10.10.13 \
-p 2022:22 -p 81:80 -p 88:88 -p 4443:443 -p 8020:8020 -p 8022:8022 -p 8032:8032 \
-p 8033:8033 -p 8080:8080 -p 8088:8088  -p 8888:8888  \
-p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 10000:10000 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 50020:50020 -p 50070:50070 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:cloudera
echo "Create host hd-c1dn2 complete!"


## hd-c1dn3
ssh ${C1DN3HOST} \
docker run -dt --name ${C1DN3} \
--network ${NETWORK} --hostname ${C1DN3} \
--ip 177.10.10.14 \
-p 2022:22 -p 81:80 -p 88:88 -p 4443:443 -p 8020:8020 -p 8022:8022 -p 8032:8032 \
-p 8033:8033 -p 8080:8080 -p 8088:8088  -p 8888:8888  \
-p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 10000:10000 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 50020:50020 -p 50070:50070 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:cloudera
echo "Create host hd-c1dn3 complete!"


## hd-c1dn4
ssh ${C1DN4HOST} \
docker run -dt --name ${C1DN4} \
--network ${NETWORK} --hostname ${C1DN4} \
--ip 177.10.10.15 \
-p 2022:22 -p 81:80 -p 88:88 -p 4443:443 -p 8020:8020 -p 8022:8022 -p 8032:8032 \
-p 8033:8033 -p 8080:8080 -p 8088:8088  -p 8888:8888  \
-p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 10000:10000 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 50020:50020 -p 50070:50070 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:cloudera
echo "Create host hd-c1dn4 complete!"
echo "+++++++++++++++++++Create clodera hosts v6.1 complete!++++++++++++++++++++++++++++"
