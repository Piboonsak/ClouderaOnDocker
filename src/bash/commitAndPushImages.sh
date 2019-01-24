
#/bin/bash

DATE=`date +%Y%m%d`
echo "${DATE}"

echo "---------------------------docker100--------------------------"
docker commit hd-c1nn piboonsak/cloudera:hd-c1nn${DATE}

echo "---------------------------docker101--------------------------"
ssh docker101 'docker commit hd-c2nn piboonsak/cloudera:hd-c2nn_'${DATE}''

echo "---------------------------docker102--------------------------"
ssh docker102 'docker commit hd-c1dn1 piboonsak/cloudera:hd-c1dn1_'${DATE}''

echo "---------------------------docker105--------------------------"
ssh docker105 'docker commit hd-c1dn2 piboonsak/cloudera:hd-c1dn2_'${DATE}''

echo "---------------------------docker106--------------------------"
ssh docker106 'docker commit hd-c1dn3 piboonsak/cloudera:hd-c1dn3_'${DATE}''

echo "---------------------------docker107--------------------------"
ssh docker107 'docker commit hd-c1dn4 piboonsak/cloudera:hd-c1dn4_'${DATE}''


echo "---------------------------push image docker100--------------------------"
docker push piboonsak/cloudera:hd-c1nn${DATE}

echo "---------------------------push image docker101--------------------------"
ssh docker101 'docker push piboonsak/cloudera:hd-c2nn_'${DATE}''

echo "---------------------------push image docker102--------------------------"
ssh docker102 'docker push piboonsak/cloudera:hd-c1dn1_'${DATE}''

echo "---------------------------push image docker105--------------------------"
ssh docker105 'docker push piboonsak/cloudera:hd-c1dn2_'${DATE}''

echo "---------------------------push image docker106--------------------------"
ssh docker106 'docker push piboonsak/cloudera:hd-c1dn3_'${DATE}''

echo "---------------------------push image docker107--------------------------"
ssh docker107 'docker push piboonsak/cloudera:hd-c1dn4_'${DATE}''


RESULT="$(docker images | egrep cloudera)"
echo "${RESULT}"
RESULT="$(ssh docker101 docker images | egrep cloudera)"
echo "${RESULT}"
RESULT="$(ssh docker102 docker images | egrep cloudera)"
echo "${RESULT}"
RESULT="$(ssh docker105 docker images | egrep cloudera)"
echo "${RESULT}"
RESULT="$(ssh docker106 docker images | egrep cloudera)"
echo "${RESULT}"
RESULT="$(ssh docker107 docker images | egrep cloudera)"
echo "${RESULT}"
