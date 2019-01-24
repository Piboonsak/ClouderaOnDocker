#!/bin/bash
## clearClouderaContainer
./clearClouderaContainer.sh
echo "#++++++++++ Complete to clear Cloudera Containers +++++++++++#"

##  removeHostRepository remove secret keys and config file another hosts.
./removeHostRepository.sh
echo "#++++++++++ Complete to Remove Host Repository +++++++++++#"

## createConfigSecret copy secret keys and config file to another hosts.
./createConfigSecret.sh
echo "#++++++++++ Complete to copy secret keys and config files +++++++++++#"

## create cloudera contaner host 
./runCreateClouderaHosts.sh
echo "#++++++++++ Complete to create cloudera container host  +++++++++++#"

## set secure keys
./setSecureKeys.sh
echo "#++++++++++ Complete to create ssh keys  +++++++++++#"

## run container
docker exec -it hd-c1nn /bin/bash
