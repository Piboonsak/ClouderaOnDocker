#!/bin/bash

## Create config and secret folder
## docker101
ssh docker101 mkdir -p /root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/config docker101:/root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/secret docker101:/root/ClouderaOnDocker/src/bash
scp jdk-8u144-linux-i586.rpm jdk-8u144-linux-i586.tar.gz docker101:/root
ssh docker101 chmod -R 777 /root/ClouderaOnDocker/src/bash/config
ssh docker101 chmod -R 400 /root/ClouderaOnDocker/src/bash/secret/*.pub
echo "docker101"
ssh docker101 ls -lah /root/ClouderaOnDocker/src/bash/config
ssh docker101 ls -lah /root/ClouderaOnDocker/src/bash/secret
ssh docker101 ls -lah /root/


## docker102
ssh docker102 mkdir -p /root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/config docker102:/root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/secret docker102:/root/ClouderaOnDocker/src/bash
scp jdk-8u144-linux-i586.rpm jdk-8u144-linux-i586.tar.gz docker102:/root
ssh docker102 chmod -R 777 /root/ClouderaOnDocker/src/bash/config
ssh docker102 chmod -R 400 /root/ClouderaOnDocker/src/bash/secret/*.pub
echo "docker102"
ssh docker102 ls -lah /root/ClouderaOnDocker/src/bash/config
ssh docker102 ls -lah /root/ClouderaOnDocker/src/bash/secret
ssh docker101 ls -lah /root/

## docker105
ssh docker105 mkdir -p /root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/config docker105:/root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/secret docker105:/root/ClouderaOnDocker/src/bash
scp jdk-8u144-linux-i586.rpm jdk-8u144-linux-i586.tar.gz docker105:/root
ssh docker105 chmod -R 777 /root/ClouderaOnDocker/src/bash/config
ssh docker105 chmod -R 400 /root/ClouderaOnDocker/src/bash/secret/*.pub
echo "docker105"
ssh docker105 ls -lah /root/ClouderaOnDocker/src/bash/config
ssh docker105 ls -lah /root/ClouderaOnDocker/src/bash/secret
ssh docker101 ls -lah /root/

## docker106
ssh docker106 mkdir -p /root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/config docker106:/root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/secret docker106:/root/ClouderaOnDocker/src/bash
scp jdk-8u144-linux-i586.rpm jdk-8u144-linux-i586.tar.gz docker106:/root
ssh docker106 chmod -R 777 /root/ClouderaOnDocker/src/bash/config
ssh docker106 chmod -R 400 /root/ClouderaOnDocker/src/bash/secret/*.pub
echo "docker106"
ssh docker106 ls -lah /root/ClouderaOnDocker/src/bash/config
ssh docker106 ls -lah /root/ClouderaOnDocker/src/bash/secret
ssh docker101 ls -lah /root/

## docker107
ssh docker107 mkdir -p /root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/config docker107:/root/ClouderaOnDocker/src/bash
scp -r /root/ClouderaOnDocker/src/bash/secret docker107:/root/ClouderaOnDocker/src/bash
scp jdk-8u144-linux-i586.rpm jdk-8u144-linux-i586.tar.gz docker107:/root
ssh docker107 chmod -R 777 /root/ClouderaOnDocker/src/bash/config
ssh docker107 chmod -R 400 /root/ClouderaOnDocker/src/bash/secret/*.pub
echo "docker107"
ssh docker107 ls -lah /root/ClouderaOnDocker/src/bash/config
ssh docker107 ls -lah /root/ClouderaOnDocker/src/bash/secret
ssh docker101 ls -lah /root/

echo "Create config and secret folder are all completed."
