#!/bin/bash
## gen cloudera scm db
## ref : **https://www.cloudera.com/documentation/enterprise/5-15-x/topics/prepare_cm_database.html#scm_prepare_syntax**
mysql -u cloudera -pTraceon1234! < CodeGenCDHdatabasev2.sql
mysql -u cloudera -pTraceon1234! -e "show databases;"

## Setting Up the Cloudera Manager Database
sudo /usr/share/cmf/schema/scm_prepare_database.sh mysql scm scm Traceon1234!