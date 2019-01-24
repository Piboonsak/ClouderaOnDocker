#!/bin/bash
# Input ssh key to cluster

## Docker node defind
C1NN_HOSTNAME="$(ssh docker100 'echo $HOSTNAME')"
C2NN_HOSTNAME="$(ssh docker101 'echo $HOSTNAME')"
C1DN1_HOSTNAME="$(ssh docker102 'echo $HOSTNAME')"
C1DN2_HOSTNAME="$(ssh docker105 'echo $HOSTNAME')"
C1DN3_HOSTNAME="$(ssh docker106 'echo $HOSTNAME')"
C1DN4_HOSTNAME="$(ssh docker107 'echo $HOSTNAME')"

## Cloudera host defind
C1NN=$(echo "hd-c1nn")
C2NN=$(echo "hd-c2nn")
C1DN1=$(echo "hd-c1dn1")
C1DN2=$(echo "hd-c1dn2")
C1DN3=$(echo "hd-c1dn3")
C1DN4=$(echo "hd-c1dn4")

## docker101 or hd-c2nn
echo "------------------------------------run insert key in host: ${HOSTNAME} to another host--------------------------"

echo "Docker node: ${C1NN_HOSTNAME}"
echo "Cloudera host: ${C1NN}"
#docker exec -it ${C1NN} ssh-copy-id root@${C1NN}

echo "Docker node: ${C2NN_HOSTNAME}"
echo "Cloudera host: ${C2NN}"
docker exec -it ${C1NN} ssh-copy-id root@${C2NN}

echo "Docker node: ${C1DN1_HOSTNAME}"
echo "Cloudera host: ${C1DN1}"
docker exec -it ${C1NN} ssh-copy-id root@${C1DN1}

echo "Docker node: ${C1DN2_HOSTNAME}"
echo "Cloudera host: ${C1DN2}"
docker exec -it ${C1NN} ssh-copy-id root@${C1DN2}

echo "Docker node: ${C1DN3_HOSTNAME}"
echo "Cloudera host: ${C1DN3}"
docker exec -it ${C1NN} ssh-copy-id root@${C1DN3}

echo "Docker node: ${C1DN4_HOSTNAME}"
echo "Cloudera host: ${C1DN4}"
docker exec -it ${C1NN} ssh-copy-id root@${C1DN4}

echo "Completed input ssh keys of host: ${C1NN} to another hosts"
