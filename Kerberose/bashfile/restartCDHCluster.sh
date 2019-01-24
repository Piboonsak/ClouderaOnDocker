#!/bin/sh

ssh hd-c1dn1 reboot now
ssh hd-c1dn2 reboot now
ssh hd-c2dn1 reboot now
ssh hd-c2dn2 reboot now
ssh hd-c2nn reboot now
ssh pdi-n1 reboot now
ssh hd-c1nn reboot now
ssh hd-c1nn /etc/hadoop/config/restartCDH.sh
