#!/bin/bash

## load image piboonsak/ubuntu:STD_16.04v3

## hd-c1nn
docker pull piboonsak/ubuntu:STD_16.04v3
echo "host hd-c1nn load completed"

## hd-c2nn
ssh docker101 docker pull piboonsak/ubuntu:STD_16.04v3
echo "host hd-c2nn load completed"

## hd-c1dn1
ssh docker102 docker pull piboonsak/ubuntu:STD_16.04v3
echo "host hd-c1dn1 load completed"

## hd-c1dn2
ssh docker105 docker pull piboonsak/ubuntu:STD_16.04v3
echo "host hd-c1dn2 load completed"

## hd-c1dn3
ssh docker106 docker pull piboonsak/ubuntu:STD_16.04v3
echo "host hd-c1dn3 load completed"

## hd-c1dn4
ssh docker107 docker pull piboonsak/ubuntu:STD_16.04v3
echo "host hd-c1dn4 load completed"
echo "All hosts load image piboonsak/ubuntu:STD_16.04v3 completed"