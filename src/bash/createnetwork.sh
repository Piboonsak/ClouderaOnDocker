#!/bin/bash
## NetCDH
docker network create NetCDH -d overlay \
--subnet 177.10.10.0/24 \
--gateway 177.10.10.1 \
--attachable

## NetCDH_bridge
docker network create NetCDH_bridge -d bridge \
--subnet 177.20.0.0/24 \
--gateway 177.20.0.1 \
--attachable

ssh docker101 \
docker network create NetCDH_bridge -d bridge \
--subnet 177.20.0.0/24 \
--gateway 177.20.0.1 \
--attachable

ssh docker102 \
docker network create NetCDH_bridge -d bridge \
--subnet 177.20.0.0/24 \
--gateway 177.20.0.1 \
--attachable

ssh docker105 \
docker network create NetCDH_bridge -d bridge \
--subnet 177.20.0.0/24 \
--gateway 177.20.0.1 \
--attachable

ssh docker106 \
docker network create NetCDH_bridge -d bridge \
--subnet 177.20.0.0/24 \
--gateway 177.20.0.1 \
--attachable

ssh docker107 \
docker network create NetCDH_bridge -d bridge \
--subnet 177.20.0.0/24 \
--gateway 177.20.0.1 \
--attachable

docker network ls
