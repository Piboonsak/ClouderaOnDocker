#!/bin/bash

mysql -u root -pCloudera01@i-net < genClouderaDB.sql
mysql -u root -pCloudera01@i-net -e "show databases;"

