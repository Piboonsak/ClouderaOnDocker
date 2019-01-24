#!/bin/bash

## remove another host repo

ssh docker101 rm -rf /root/ClouderaOnDocker
echo "Already remove on host docker101"
ssh docker101 ls -lah /root

ssh docker102 rm -rf /root/ClouderaOnDocker
echo "Already remove on host docker102"
ssh docker102 ls -lah /root

ssh docker105 rm -rf /root/ClouderaOnDocker
echo "Already remove on host docker105"
ssh docker105 ls -lah /root

ssh docker106 rm -rf /root/ClouderaOnDocker
echo "Already remove on host docker106"
ssh docker106 ls -lah /root

ssh docker107 rm -rf /root/ClouderaOnDocker
echo "Already remove on host docker107"
ssh docker107 ls -lah /root

echo "Already remove all hosts"
