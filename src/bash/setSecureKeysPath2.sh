#!/bin/bash
## run move file

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

## Copy file to another host
scp /root/ClouderaOnDocker/src/bash/input_hd-c2nn_SSHKey.sh ${C2NN_HOSTNAME}:/root
scp /root/ClouderaOnDocker/src/bash/input_hd-c1dn1_SSHKey.sh ${C1DN1_HOSTNAME}:/root
scp /root/ClouderaOnDocker/src/bash/input_hd-c1dn2_SSHKey.sh ${C1DN2_HOSTNAME}:/root
scp /root/ClouderaOnDocker/src/bash/input_hd-c1dn3_SSHKey.sh ${C1DN3_HOSTNAME}:/root
scp /root/ClouderaOnDocker/src/bash/input_hd-c1dn4_SSHKey.sh ${C1DN4_HOSTNAME}:/root

## run file
./root/ClouderaOnDocker/src/bash/input_hd-c1nn_SSHKey.sh
ssh ${C2NN_HOSTNAME} /root/input_hd-c2nn_SSHKey.sh
ssh ${C1DN1_HOSTNAME} /root/input_hd-c1dn1_SSHKey.sh
ssh ${C1DN2_HOSTNAME} /root/input_hd-c1dn2_SSHKey.sh
ssh ${C1DN3_HOSTNAME} /root/input_hd-c1dn3_SSHKey.sh
ssh ${C1DN4_HOSTNAME} /root/input_hd-c1dn4_SSHKey.sh
