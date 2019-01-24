#!/bin/bash

docker stop hd-c1nn
ssh docker101 docker stop hd-c2nn
ssh docker102 docker stop hd-c1dn1
ssh docker105 docker stop hd-c1dn2
ssh docker106 docker stop hd-c1dn3
ssh docker107 docker stop hd-c1dn4

echo "---------------Stop All--------------"
