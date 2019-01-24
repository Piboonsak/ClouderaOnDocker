#!/bin/bash
## Create volume
docker volume create cdhDB
docker volume create c1nn
ssh docker101 docker volume create c2nn
ssh docker102 docker volume create c1dn1
ssh docker105 docker volume create c1dn2
ssh docker106 docker volume create c1dn3
ssh docker107 docker volume create c1dn4
