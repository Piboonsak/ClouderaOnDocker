#!/bin/bash
## Create authorized_keys
cat .ssh/id_rsa.pub > .ssh/authorized_keys
ssh hd-c2nn cat .ssh/id_rsa.pub >> .ssh/authorized_keys
ssh hd-c1dn1 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
ssh hd-c1dn2 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
ssh hd-c1dn3 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
ssh hd-c1dn4 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
cat .ssh/id_rsa.pub

ssh hd-c2nn
ssh hd-c1dn1
ssh hd-c1dn2
ssh hd-c1dn3
ssh hd-c1dn4

scp .ssh/authorized_keys hd-c2nn:/root/.ssh/
scp .ssh/authorized_keys hd-c1dn1:/root/.ssh/
scp .ssh/authorized_keys hd-c1dn2:/root/.ssh/
scp .ssh/authorized_keys hd-c1dn3:/root/.ssh/
scp .ssh/authorized_keys hd-c1dn4:/root/.ssh/

echo "-----------------------at hd-c1nn-------------------------"
ssh hd-c2nn
ssh hd-c1dn1
ssh hd-c1dn2
ssh hd-c1dn3
ssh hd-c1dn4

echo "-----------------------at hd-c2nn-------------------------"
ssh hd-c2nn ssh hd-c1nn
ssh hd-c1dn1
ssh hd-c1dn2
ssh hd-c1dn3
ssh hd-c1dn4

echo "-----------------------at hd-c1dn1-------------------------"
ssh hd-c1dn1 ssh hd-c1nn
ssh hd-c2nn
ssh hd-c1dn2
ssh hd-c1dn3
ssh hd-c1dn4

echo "-----------------------at hd-c1dn2-------------------------"
ssh hd-c1dn2 ssh hd-c1nn
ssh hd-c2nn
ssh hd-c1dn1
ssh hd-c1dn3
ssh hd-c1dn4

echo "-----------------------at hd-c1dn3-------------------------"
ssh hd-c1dn3 ssh hd-c1nn
ssh hd-c2nn
ssh hd-c1dn1
ssh hd-c1dn2
ssh hd-c1dn4

echo "-----------------------at hd-c1dn4-------------------------"
ssh hd-c1dn4 ssh hd-c1nn
ssh hd-c2nn
ssh hd-c1dn1
ssh hd-c1dn2
ssh hd-c1dn3

echo "-----------------------Check ssh keys completed -------------------------"
## Update package

apt-get update
ssh hd-c2nn apt-get update
ssh hd-c1dn1 apt-get update
ssh hd-c1dn2 apt-get update
ssh hd-c1dn3 apt-get update
ssh hd-c1dn4 apt-get update

echo "-----------------------update package completed -------------------------"

service apache2 start
ssh hd-c2nn service apache2 start
ssh hd-c1dn1 service apache2 start
ssh hd-c1dn2 service apache2 start
ssh hd-c1dn3 service apache2 start
ssh hd-c1dn4 service apache2 start


echo "-----------------------Start service apache2 completed -------------------------"

