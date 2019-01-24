#!/bin/bash
## start cluster service ssh.

## hd-c1nn
docker exec -it hd-c1nn service ssh start
RESULT_C1NN="$(docker exec -it hd-c1nn service ssh status)"
echo "$HOSTNAME : ${RESULT_C1NN}"

docker exec -it db-cdh service ssh start
RESULT_DBCDH="$(docker exec -it db-cdh service ssh status)"
echo "$HOSTNAME : ${RESULT_DBCDH}"

## hd-c2nn
ssh docker101 'docker exec -i hd-c2nn service ssh start'
C2NN_RESULT="$(ssh docker101 'docker exec -i hd-c2nn service ssh status')"
C2NN_HOSTNAME="$(ssh docker101 'echo $HOSTNAME')"
echo "${C2NN_HOSTNAME}: ${C2NN_RESULT}"

## hd-c1dn1
ssh docker102 'docker exec -i hd-c1dn1 service ssh start'
C1DN1_RESULT="$(ssh docker102 'docker exec -i hd-c1dn1 service ssh status')"
C1DN1_HOSTNAME="$(ssh docker102 'echo $HOSTNAME')"
echo "${C1DN1_HOSTNAME}: ${C1DN1_RESULT}"


## hd-c1dn2
ssh docker105 'docker exec -i hd-c1dn2 service ssh start'
C1DN2_RESULT="$(ssh docker105 'docker exec -i hd-c1dn2 service ssh status')"
C1DN2_HOSTNAME="$(ssh docker105 'echo $HOSTNAME')"
echo "${C1DN2_HOSTNAME}: ${C1DN2_RESULT}"


## hd-c1dn3
ssh docker106 'docker exec -i hd-c1dn3 service ssh start'
C1DN3_RESULT="$(ssh docker106 'docker exec -i hd-c1dn3 service ssh status')"
C1DN3_HOSTNAME="$(ssh docker106 'echo $HOSTNAME')"
echo "${C1DN3_HOSTNAME}: ${C1DN3_RESULT}"


## hd-c1dn4
ssh docker107 'docker exec -i hd-c1dn4 service ssh start'
C1DN4_RESULT="$(ssh docker107 'docker exec -i hd-c1dn4 service ssh status')"
C1DN4_HOSTNAME="$(ssh docker107 'echo $HOSTNAME')"
echo "${C1DN4_HOSTNAME}: ${C1DN4_RESULT}"


#---------------------------------------------------------------------------#
## set cluster secure key

echo "$HOSTNAME"
docker exec -it hd-c1nn /bin/sh -c ssh-keygen -q
docker exec -it db-cdh /bin/sh -c ssh-keygen -q

echo "${C2NN_HOSTNAME}"
ssh docker101 'docker exec -i hd-c2nn /bin/sh -c ssh-keygen -q'

echo "${C1DN1_HOSTNAME}"
ssh docker102 'docker exec -i hd-c1dn1 /bin/sh -c ssh-keygen -q'

echo "${C1DN2_HOSTNAME}"
ssh docker105 'docker exec -i hd-c1dn2 /bin/sh -c ssh-keygen -q'

echo "${C1DN3_HOSTNAME}"
ssh docker106 'docker exec -i hd-c1dn3 /bin/sh -c ssh-keygen -q'

echo "${C1DN4_HOSTNAME}"
ssh docker107 'docker exec -i hd-c1dn4 /bin/sh -c ssh-keygen -q'

echo "############# Completed generate secure keys in cluster ! ##############"

#---------------------------------------------------------------------------------------#


## Create authorized_keys
#cat .ssh/id_rsa.pub > .ssh/authorized_keys
#ssh hd-c2nn cat .ssh/id_rsa.pub >> .ssh/authorized_keys
#ssh hd-c1dn1 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
#ssh hd-c1dn2 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
#ssh hd-c1dn3 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
#ssh hd-c1dn4 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
#cat .ssh/id_rsa.pub

#ssh hd-c2nn
#ssh hd-c1dn1
#ssh hd-c1dn2
#ssh hd-c1dn3
#ssh hd-c1dn4
