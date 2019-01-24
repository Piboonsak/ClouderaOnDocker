#/bin/bash

DATE=`date +%Y%m%d`
echo "${DATE}"

echo "---------------------------docker100--------------------------"
docker commit hd-c1nn cloudera:hd-c1nn_${DATE}
RESULT="$(docker images | egrep cloudera)"
echo "${RESULT}"

echo "---------------------------docker101--------------------------"
ssh docker101 'docker commit hd-c2nn cloudera:hd-c2nn_'${DATE}''
RESULT="$(ssh docker101 docker images | egrep cloudera)"
echo "${RESULT}"

echo "---------------------------docker102--------------------------"
ssh docker102 'docker commit hd-c1dn1 cloudera:hd-c1dn1_'${DATE}''
RESULT="$(ssh docker102 docker images | egrep cloudera)"
echo "${RESULT}"

echo "---------------------------docker105--------------------------"
ssh docker105 'docker commit hd-c1dn2 cloudera:hd-c1dn2_'${DATE}''
RESULT="$(ssh docker105 docker images | egrep cloudera)"
echo "${RESULT}"

echo "---------------------------docker106--------------------------"
ssh docker106 'docker commit hd-c1dn3 cloudera:hd-c1dn3_'${DATE}''
RESULT="$(ssh docker106 docker images | egrep cloudera)"
echo "${RESULT}"

echo "---------------------------docker107--------------------------"
ssh docker107 'docker commit hd-c1dn4 cloudera:hd-c1dn4_'${DATE}''
RESULT="$(ssh docker107 docker images | egrep cloudera)"
echo "${RESULT}"
