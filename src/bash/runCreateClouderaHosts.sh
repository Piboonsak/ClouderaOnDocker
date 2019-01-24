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
DBCDH=$(echo "db-cdh")

#Pull image
IMAGE=$(echo "piboonsak/ubuntu:clouderaV2")
IMAGEDB=$(echo "piboonsak/ubuntu:db-cdh")
docker pull ${IMAGE}
docker pull ${IMAGEDB}
ssh ${C2NNHOST} docker pull ${IMAGE}
ssh ${C1DN1HOST} docker pull ${IMAGE}
ssh ${C1DN2HOST} docker pull ${IMAGE}
ssh ${C1DN3HOST} docker pull ${IMAGE}
ssh ${C1DN4HOST} docker pull ${IMAGE}

## Network defind
NETWORK=$(echo "NetCDH")
NETBRIDGE=$(echo "NetCDH_bridge")

# Set host ulimit
ulimit -l unlimited
ssh ${C2NNHOST} ulimit -l unlimited
ssh ${C1DN1HOST} ulimit -l unlimited
ssh ${C1DN2HOST} ulimit -l unlimited
ssh ${C1DN3HOST} ulimit -l unlimited
ssh ${C1DN4HOST} ulimit -l unlimited

echo "-----------------${C1NNHOST} unlimited -----------------"
ulimit -l

echo "-----------------${C2NNHOST} ulimitted -----------------"
ssh ${C2NNHOST} ulimit -l

echo "-----------------${C1DN1HOST} ulimitted -----------------"
ssh ${C1DN1HOST} ulimit -l

echo "-----------------${C1DN2HOST} ulimitted -----------------"
ssh ${C1DN2HOST} ulimit -l

echo "-----------------${C1DN3HOST} ulimitted -----------------"
ssh ${C1DN3HOST} ulimit -l

echo "-----------------${C1DN4HOST} ulimitted -----------------"
ssh ${C1DN4HOST} ulimit -l


# Set swappiness
sysctl vm.swappiness=0
ssh ${C2NNHOST} sysctl vm.swappiness=0
ssh ${C1DN1HOST} sysctl vm.swappiness=0
ssh ${C1DN2HOST} sysctl vm.swappiness=0
ssh ${C1DN3HOST} sysctl vm.swappiness=0
ssh ${C1DN4HOST} sysctl vm.swappiness=0

echo "-----------------${C1NNHOST} swappiness -----------------"
cat /proc/sys/vm/swappiness

echo "-----------------${C2NNHOST} swappiness -----------------"
ssh ${C2NNHOST} cat /proc/sys/vm/swappiness

echo "-----------------${C1DN1HOST} swappiness -----------------"
ssh ${C1DN1HOST} cat /proc/sys/vm/swappiness

echo "-----------------${C1DN2HOST} swappiness -----------------"
ssh ${C1DN2HOST} cat /proc/sys/vm/swappiness

echo "-----------------${C1DN3HOST} swappiness -----------------"
ssh ${C1DN3HOST} cat /proc/sys/vm/swappiness

echo "-----------------${C1DN4HOST} swappiness -----------------"
ssh ${C1DN4HOST} cat /proc/sys/vm/swappiness


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
--network ${NETBRIDGE} --hostname ${C1NN} -l namenode \
--ip 172.20.0.11 \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
--restart=unless-stopped --sig-proxy=true \
-p 2022:22 -p 81:80 -p 88:88 -p 111:111 -p 4443:443 -p 1004:1004 -p 1006:1006 \
-p 2049:2049 -p 2181:2181 -p 4242:4242 -p 7077:7077 -p 7078:7078 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 8005:8005 -p 8020:8020 -p 8022:8022 -p 8032:8032 -p 8033:8033 -p 8038:8038 \
-p 8080:8080 -p 8042:8042 -p 8044:8044 -p 8085:8085 -p 8088:8088 -p 8888:8888 \
-p 8090:8090 -p 9000:9000 -p 9083:9083 -p 9090:9090 \
-p 9091:9091 -p 9092:9092 -p 9093:9093 -p 9095:9095 \
-p 10000:10000 -p 10002:10002 -p 11000:11000 -p 11060:11060 \
-p 11443:11443 -p 12000:12000 -p 12001:12001 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 18081:18081 -p 18088:18088 -p 19888:19888 -p 19890:19890 \
-p 20550:20550 -p 24042:24042 -p 41414:41414 \
-p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 \
-p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/cloudera-manager-installer.bin:/root/cloudera-manager-installer.bin \
-v /root/ClouderaOnDocker/src/bash/secret/createAuthorizedKey.sh:/root/createAuthorizedKey.sh \
${IMAGE}
echo "Create host hd-c1nn complete!"


## hd-c2nn
ssh ${C2NNHOST} \
docker run -dt --name ${C2NN} \
--network ${NETBRIDGE} --hostname ${C2NN} -l namenode \
--ip 177.10.10.11 \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
--restart=unless-stopped --sig-proxy=true \
-p 2022:22 -p 81:80 -p 88:88 -p 111:111 -p 4443:443 -p 1004:1004 -p 1006:1006 \
-p 2049:2049 -p 2181:2181 -p 4242:4242 -p 7077:7077 -p 7078:7078 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 8005:8005 -p 8020:8020 -p 8022:8022 -p 8032:8032 -p 8033:8033 -p 8038:8038 \
-p 8080:8080 -p 8042:8042 -p 8044:8044 -p 8085:8085 -p 8088:8088 -p 8888:8888 \
-p 8090:8090 -p 9000:9000 -p 9083:9083 -p 9090:9090 \
-p 9091:9091 -p 9092:9092 -p 9093:9093 -p 9095:9095 \
-p 10000:10000 -p 10002:10002 -p 11000:11000 -p 11060:11060 \
-p 11443:11443 -p 12000:12000 -p 12001:12001 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 18081:18081 -p 18088:18088 -p 19888:19888 -p 19890:19890 \
-p 20550:20550 -p 24042:24042 -p 41414:41414 \
-p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 \
-p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
${IMAGE}
echo "Create host hd-c2nn complete!"


## hd-c1dn1
ssh ${C1DN1HOST} \
docker run -dt --name ${C1DN1} \
--network ${NETBRIDGE} --hostname ${C1DN1} -l datanode \
--ip 177.10.10.12 \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
--restart=unless-stopped --sig-proxy=true \
-p 2022:22 -p 81:80 -p 88:88 -p 111:111 -p 4443:443 -p 1004:1004 -p 1006:1006 \
-p 2049:2049 -p 2181:2181 -p 4242:4242 -p 7077:7077 -p 7078:7078 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 8005:8005 -p 8020:8020 -p 8022:8022 -p 8032:8032 -p 8033:8033 -p 8038:8038 \
-p 8080:8080 -p 8042:8042 -p 8044:8044 -p 8085:8085 -p 8088:8088 -p 8888:8888 \
-p 8090:8090 -p 9000:9000 -p 9083:9083 -p 9090:9090 \
-p 9091:9091 -p 9092:9092 -p 9093:9093 -p 9095:9095 \
-p 10000:10000 -p 10002:10002 -p 11000:11000 -p 11060:11060 \
-p 11443:11443 -p 12000:12000 -p 12001:12001 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 18081:18081 -p 18088:18088 -p 19888:19888 -p 19890:19890 \
-p 20550:20550 -p 24042:24042 -p 41414:41414 \
-p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 \
-p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
${IMAGE}
echo "Create host hd-c1dn1 complete!"


## hd-c1dn2
ssh ${C1DN2HOST} \
docker run -dt --name ${C1DN2} \
--network ${NETBRIDGE} --hostname  ${C1DN2} -l datanode \
--ip 177.10.10.13 \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
--restart=unless-stopped --sig-proxy=true \
-p 2022:22 -p 81:80 -p 88:88 -p 111:111 -p 4443:443 -p 1004:1004 -p 1006:1006 \
-p 2049:2049 -p 2181:2181 -p 4242:4242 -p 7077:7077 -p 7078:7078 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 8005:8005 -p 8020:8020 -p 8022:8022 -p 8032:8032 -p 8033:8033 -p 8038:8038 \
-p 8080:8080 -p 8042:8042 -p 8044:8044 -p 8085:8085 -p 8088:8088 -p 8888:8888 \
-p 8090:8090 -p 9000:9000 -p 9083:9083 -p 9090:9090 \
-p 9091:9091 -p 9092:9092 -p 9093:9093 -p 9095:9095 \
-p 10000:10000 -p 10002:10002 -p 11000:11000 -p 11060:11060 \
-p 11443:11443 -p 12000:12000 -p 12001:12001 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 18081:18081 -p 18088:18088 -p 19888:19888 -p 19890:19890 \
-p 20550:20550 -p 24042:24042 -p 41414:41414 \
-p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 \
-p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
${IMAGE}
echo "Create host hd-c1dn2 complete!"


## hd-c1dn3
ssh ${C1DN3HOST} \
docker run -dt --name ${C1DN3} \
--network ${NETBRIDGE} --hostname ${C1DN3} -l datanode \
--ip 177.10.10.14 \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
--restart=unless-stopped --sig-proxy=true \
-p 2022:22 -p 81:80 -p 88:88 -p 111:111 -p 4443:443 -p 1004:1004 -p 1006:1006 \
-p 2049:2049 -p 2181:2181 -p 4242:4242 -p 7077:7077 -p 7078:7078 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 8005:8005 -p 8020:8020 -p 8022:8022 -p 8032:8032 -p 8033:8033 -p 8038:8038 \
-p 8080:8080 -p 8042:8042 -p 8044:8044 -p 8085:8085 -p 8088:8088 -p 8888:8888 \
-p 8090:8090 -p 9000:9000 -p 9083:9083 -p 9090:9090 \
-p 9091:9091 -p 9092:9092 -p 9093:9093 -p 9095:9095 \
-p 10000:10000 -p 10002:10002 -p 11000:11000 -p 11060:11060 \
-p 11443:11443 -p 12000:12000 -p 12001:12001 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 18081:18081 -p 18088:18088 -p 19888:19888 -p 19890:19890 \
-p 20550:20550 -p 24042:24042 -p 41414:41414 \
-p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 \
-p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
${IMAGE}
echo "Create host hd-c1dn3 complete!"


## hd-c1dn4
ssh ${C1DN4HOST} \
docker run -dt --name ${C1DN4} \
--network ${NETBRIDGE} --hostname ${C1DN4} -l datanode \
--ip 177.10.10.15 \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
--restart=unless-stopped --sig-proxy=true \
-p 2022:22 -p 81:80 -p 88:88 -p 111:111 -p 4443:443 -p 1004:1004 -p 1006:1006 \
-p 2049:2049 -p 2181:2181 -p 4242:4242 -p 7077:7077 -p 7078:7078 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 8005:8005 -p 8020:8020 -p 8022:8022 -p 8032:8032 -p 8033:8033 -p 8038:8038 \
-p 8080:8080 -p 8042:8042 -p 8044:8044 -p 8085:8085 -p 8088:8088 -p 8888:8888 \
-p 8090:8090 -p 9000:9000 -p 9083:9083 -p 9090:9090 \
-p 9091:9091 -p 9092:9092 -p 9093:9093 -p 9095:9095 \
-p 10000:10000 -p 10002:10002 -p 11000:11000 -p 11060:11060 \
-p 11443:11443 -p 12000:12000 -p 12001:12001 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 18081:18081 -p 18088:18088 -p 19888:19888 -p 19890:19890 \
-p 20550:20550 -p 24042:24042 -p 41414:41414 \
-p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 \
-p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
${IMAGE}
echo "Create host hd-c1dn4 complete!"


## db-cdh
docker run -dt --name ${DBCDH} \
--network ${NETBRIDGE} --hostname ${DBCDH} \
--ip 177.10.10.206 \
-p 2200:22 -p 33306:3306 \
--restart=unless-stopped --sig-proxy=true \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/sshd_config:/etc/ssh/sshd_config \
-v /root/ClouderaOnDocker/src/mysql-connector-java-5.1.47-bin.jar:/usr/share/java \
-v /root/ClouderaOnDocker/src/mysql-connector-java-5.1.47.jar:/usr/share/java \
-v cdhDB:/var/lib/mysql \
${IMAGEDB}
echo "Create host db-cdh complete!"

echo "+++++++++++++++++++Create clodera hosts by Image ${IMAGE} v6.1 complete!++++++++++++++++++++++++++++"


## connect network

docker network connect NetCDH --alias ${C1NN} --ip 177.10.10.10 ${C1NN}
ssh ${C2NNHOST} network connect ${NETWORK} --alias ${C2NN} --ip 177.10.10.11 ${C2NN}
ssh ${C1DN1HOST} network connect ${NETWORK} --alias ${C1DN1} --ip 177.10.10.12 ${C1DN1}
ssh ${C1DN2HOST} network connect ${NETWORK} --alias ${C1DN2} --ip 177.10.10.13 ${C1DN2}
ssh ${C1DN3HOST} network connect ${NETWORK} --alias ${C1DN3} --ip 177.10.10.14 ${C1DN3}
ssh ${C1DN4HOST} network connect ${NETWORK} --alias ${C1DN4} --ip 177.10.10.15 ${C1DN4}
ssh ${C1NN} network connect ${NETWORK} --alias ${DBCDH} --ip 177.10.10.206 ${DBCDH}

echo "+++++++++++++++++++connect network: ${NETWORK} complete!++++++++++++++++++++++++++++"
