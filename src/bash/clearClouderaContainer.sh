#!/bin/bash

docker stop hd-c1nn
docker stop db-cdh
ssh docker101 docker stop hd-c2nn
ssh docker102 docker stop hd-c1dn1
ssh docker105 docker stop hd-c1dn2
ssh docker106 docker stop hd-c1dn3
ssh docker107 docker stop hd-c1dn4

docker rm hd-c1nn
docker rm db-cdh
ssh docker101 docker rm hd-c2nn
ssh docker102 docker rm hd-c1dn1
ssh docker105 docker rm hd-c1dn2
ssh docker106 docker rm hd-c1dn3
ssh docker107 docker rm hd-c1dn4

./listClouderaContainer.sh
