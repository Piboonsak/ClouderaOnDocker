# Cloudera on docker

## Add more reacher on swarm.  
### Check swarm

`docker node ls`<br>

```sh
root@docker100:~# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
t6lzlmlgi0guuqxgxtli5gaam *   docker100           Ready               Active              Leader              18.06.0-ce
5sm7tgb3x939ylfclxcb66p7g     docker101           Ready               Active              Reachable           18.06.0-ce
2jrc8ohqm2yu56cqxlq0bvcwj     docker102           Ready               Active                                  18.06.0-ce
0s6t6ec1grkga0gydeb9is808     docker103           Ready               Active                                  18.06.0-ce
e9plvd3x20aw0v1g5yxd353pm     docker104           Ready               Active                                  18.06.1-ce
r936wsylwhft5fa826zzziet1     docker105           Ready               Active              Reachable           18.06.0-ce
```

### Check swarm token

`docker swarm join-token manager`<br>

```sh
root@docker100:~# docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-65sbts17ywloq8xhgntcbd02bs8jxh01zpciinrtx3uki0gjs7-cspwqxq7cjj8clbu86yq0uf68 192.168.23.100:2377

```
### update --role manager to another node
**Because overlay reach only Reachable docker nodes**<br>

<b>At worker node</b>
docker node update --role manager
or

<b>At manager node</b>
docker node promote docker105

```sh
root@docker100:~# docker node promote docker105
Node docker105 promoted to a manager in the swarm.
root@docker100:~# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
t6lzlmlgi0guuqxgxtli5gaam *   docker100           Ready               Active              Reachable           18.06.0-ce
5sm7tgb3x939ylfclxcb66p7g     docker101           Ready               Active              Leader              18.06.0-ce
2jrc8ohqm2yu56cqxlq0bvcwj     docker102           Ready               Active              Reachable           18.06.0-ce
pj6wnsye64uwlcn0gum6tvpjf     docker103           Ready               Active                                  18.06.0-ce
7ym3wvs0skkodnosxsoctpab3     docker104           Ready               Active                                  18.06.1-ce
r936wsylwhft5fa826zzziet1     docker105           Ready               Active              Reachable           18.06.0-ce
root@docker100:~# 

```
### demote to worker
```sh
root@docker100:~# docker node demote docker105
Manager docker105 demoted in the swarm.
root@docker100:~# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
t6lzlmlgi0guuqxgxtli5gaam *   docker100           Ready               Active              Reachable           18.06.0-ce
5sm7tgb3x939ylfclxcb66p7g     docker101           Ready               Active              Leader              18.06.0-ce
2jrc8ohqm2yu56cqxlq0bvcwj     docker102           Ready               Active              Reachable           18.06.0-ce
pj6wnsye64uwlcn0gum6tvpjf     docker103           Ready               Active                                  18.06.0-ce
7ym3wvs0skkodnosxsoctpab3     docker104           Ready               Active                                  18.06.1-ce
r936wsylwhft5fa826zzziet1     docker105           Ready               Active                                  18.06.0-ce
root@docker100:~# 

```
---------------------------------------------------------------------------------
## Create overlay network

docker network create cloudera -d overlay \
--subnet 177.10.10.0/24 \
--gateway 177.10.10.1 \
--attachable

```sh
root@docker100:~# docker network create cloudera -d overlay \
> --subnet 177.10.10.0/24 \
> --gateway 177.10.10.1 \
> --attachable
0f5ct933cjf2qablxf91jopzw
root@docker100:~# docker network ls
NETWORK ID          NAME                      DRIVER              SCOPE
c27852018dd7        bridge                    bridge              local
0f5ct933cjf2        cloudera                  overlay             swarm
f02eb53a9cde        docker_gwbridge           bridge              local
ooed65s12zjm        elk_elk                   overlay             swarm
1dec40a14de3        host                      host                local
idvhyth9lg0a        ingress                   overlay             swarm
20ed4cdc2e96        none                      null                local
tkbz7567svly        portainer_agent_network   overlay             swarm
```
---------------------------------------------------------------------------------
## ex
docker network connect --ip 172.20.128.2 multi-host-network container2

docker network create \
  --driver=bridge \
  --subnet=172.28.0.0/16 \
  --ip-range=172.28.5.0/24 \
  --gateway=172.28.5.254 \
  br0

 docker network create -d overlay \
  --subnet=192.168.1.0/25 \
  --subnet=192.170.2.0/25 \
  --gateway=192.168.1.100 \
  --gateway=192.170.2.100 \
  --aux-address="my-router=192.168.1.5" --aux-address="my-switch=192.168.1.6" \
  --aux-address="my-printer=192.170.1.5" --aux-address="my-nas=192.170.1.6" \
  my-multihost-network

---------------------------------------------------------------------------------

## Create preInstall Container
### ex

```yml
FROM ubuntu:16.04
MAINTAINER Piboonsak Pimsarn (PiboonsakTraceon@gmail.com) 
LABEL Description="ubuntu STD v2.1"
ENV ubuntu=16.04
RUN apt-get update && apt-get install -y \
	nano \
	vim \
	wget \
	curl \
	htop \
	man \
	net-tools \
        iptables iptables-persistent
RUN apt-get install -y iputils-ping
RUN apt-get install -y openssh-server
RUN service ssh restart
RUN mkdir -p /myapp
WORKDIR /myapp
EXPOSE 80/tcp 22/tcp 3306/tcp 443/tcp 8080/tcp 8088/tcp
CMD service ssh start
 
```

---------------------------------------------------------------------------------

```yml
FROM ubuntu:18.04
MAINTAINER Piboonsak Pimsarn (PiboonsakTraceon@gmail.com) 
LABEL Description="ubuntu 18.04 STD ver 1.0"
ENV ubuntu=18.04
RUN apt-get update && apt-get install -y \
	nano \
	vim \
	wget \
	curl \
	htop \
	man \
	net-tools \
        iptables iptables-persistent
RUN apt-get install -y iputils-ping
RUN apt-get install -y openssh-server
RUN service ssh restart
RUN mkdir -p /myapp
WORKDIR /myapp
EXPOSE 22/tcp 25/tcp 53/tcp 80/tcp 88/tcp 389/tcp 443/tcp 636/tcp 749/tcp \
1004/tcp 1006/tcp 2181/tcp 2377/tcp 3306/tcp 4732/tcp 6066/tcp 7077/tcp 7180/tcp \
8020/tcp 8070/tcp 8080/tcp 8485/tcp 8088/tcp 8888/tcp 8998/tcp 9083/tcp \
10000/tcp 11000/tcp 14000/tcp 18080/tcp 21050/tcp \
50020/tcp 50070/tcp 50470/tcp 50770/tcp 60010/tcp
CMD service ssh start
 
```


## create file on server and run command `docker build .` in that folder

```
root@docker100:~/Dockerfiles# cd ./ubuntu/
root@docker100:~/Dockerfiles/ubuntu# ls
dockerfile
root@docker100:~/Dockerfiles/ubuntu# mkdir -p ./1804
root@docker100:~/Dockerfiles/ubuntu# ls
1804  dockerfile
root@docker100:~/Dockerfiles/ubuntu# cd ./1804/
root@docker100:~/Dockerfiles/ubuntu/1804# nano dockerfile
root@docker100:~/Dockerfiles/ubuntu/1804# docker build .
Sending build context to Docker daemon   2.56kB
Step 1/12 : FROM ubuntu:18.04
18.04: Pulling from library/ubuntu
124c757242f8: Already exists 
9d866f8bde2a: Pull complete 
fa3f2f277e67: Pull complete 
398d32b153e8: Pull complete 
afde35469481: Pull complete 
Digest: sha256:de774a3145f7ca4f0bd144c7d4ffb2931e06634f11529653b23eba85aef8e378
Status: Downloaded newer image for ubuntu:18.04
 ---> cd6d8154f1e1
Step 2/12 : MAINTAINER Piboonsak Pimsarn (PiboonsakTraceon@gmail.com)
 ---> Running in e2e82d28220e

```

## Name image by command `docker tag`

```
root@docker100:~/Dockerfiles/ubuntu/1804# docker tag bacf6c0b05aa ubuntu:STDv18.04
root@docker100:~/Dockerfiles/ubuntu/1804# docker images
REPOSITORY                                          TAG                 IMAGE ID            CREATED              SIZE
ubuntu                                              STDv18.04           bacf6c0b05aa        About a minute ago   293MB
clouder                                             preinstall          3e64846b99e7        24 hours ago         265MB
```
---------------------------------------------------------------------------------
## Run images

### ex
```
root@docker105:~# docker run -dt --name CDH-datanode \
> -p 20022:22 -p 20021:21 -p 20080:80 -p 23306:3306 \
> --network cloudera --hostname CDH-datanode \
> ubuntu1604_buildv2.1:latest
e1364f0ab250ca7ac6c707a11b8ec5cb2f183236ff68c55e7db14adbde334fbe
```
`docker run -itd --network=my-net --ip=10.10.9.75 busybox`

## Run

### run test 

`docker run -dt --name preInstall ubuntu:STDv18.04`


## run

### Ex1
docker run -dt --name preInstallv3 \
--network cloudera --hostname preInstallv3 \
--ip 177.10.10.31 \
-p 2222:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 2377:2377 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
ubuntu:STDv18.04

### Ex2
docker run -dt --name preInstallv5 \
--network cloudera --hostname preInstallv5 \
-p 22:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
--ip 177.10.10.42 \
ubuntu:STDv18.04

### Ex3 Work 
**Becareful conflict port when run docker run -p.The port don't use by another container in same host**

docker run -dt --name preInstall \
--network cloudera --hostname preInstall \
--ip 177.10.10.11 \
-p 2022:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
ubuntu:STDv18.04

### [Clouder port](https://www.cloudera.com/documentation/enterprise/5-14-x/topics/cdh_ig_ports_cdh5.html)
```
22/tcp 25/tcp 53/tcp 80/tcp 88/tcp 389/tcp 443/tcp 636/tcp 749/tcp \
1004/tcp 1006/tcp 2181/tcp 2377/tcp 3306/tcp 4732/tcp 6066/tcp 7077/tcp \
8020/tcp 8070/tcp 8080/tcp 8485/tcp 8088/tcp 8888/tcp 8998/tcp 9083/tcp \
10000/tcp 11000/tcp 14000/tcp 18080/tcp 21050/tcp \
50020/tcp 50070/tcp 50470/tcp 50770/tcp 60010/tcp
```

```sh
root@docker100:~/Dockerfiles/ubuntu/1804# docker run -dt --name preInstall \
> --network cloudera --hostname preInstall \
> --ip 177.10.10.11 \
> -p 2022:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
> -p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
> -p 2181:2181 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
> -p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
> -p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
> -p 18080:18080 -p 21050:21050 -p 23306:3306 \
> -p 50020:50020 -p 50070:50070 -p 50470:50470 \
> -p 50770:50770 -p 60010:60010 \
> ubuntu:STDv18.04
b3fcb0da10a7e01b320ec756f83ab2fdae808626f8800d4181c0ef3685b25b5e
root@docker100:~/Dockerfiles/ubuntu/1804# docker container ls
CONTAINER ID        IMAGE                                                     COMMAND                  CREATED             STATUS              PORTS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         NAMES
b3fcb0da10a7        ubuntu:STDv18.04                                          "/bin/bash"              9 seconds ago       Up 8 seconds        25/tcp, 0.0.0.0:80->80/tcp, 0.0.0.0:88->88/tcp, 0.0.0.0:389->389/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:636->636/tcp, 0.0.0.0:749->749/tcp, 0.0.0.0:1004->1004/tcp, 0.0.0.0:1006->1006/tcp, 53/tcp, 0.0.0.0:2181->2181/tcp, 0.0.0.0:4732->4732/tcp, 0.0.0.0:6066->6066/tcp, 0.0.0.0:7077->7077/tcp, 2377/tcp, 8020/tcp, 0.0.0.0:7180->7180/tcp, 0.0.0.0:8080->8080/tcp, 8070/tcp, 0.0.0.0:8088->8088/tcp, 8485/tcp, 0.0.0.0:8888->8888/tcp, 0.0.0.0:9083->9083/tcp, 0.0.0.0:10000->10000/tcp, 0.0.0.0:11000->11000/tcp, 0.0.0.0:14000->14000/tcp, 0.0.0.0:18080->18080/tcp, 0.0.0.0:21050->21050/tcp, 0.0.0.0:50020->50020/tcp, 0.0.0.0:50070->50070/tcp, 0.0.0.0:50470->50470/tcp, 0.0.0.0:50770->50770/tcp, 8998/tcp, 0.0.0.0:60010->60010/tcp, 0.0.0.0:2022->22/tcp, 0.0.0.0:23306->3306/tcp   preInstall

```


com.docker.network.bridge.enable_icc	--icc	Enable or disable inter container connectivity

# Istall step
## Step 1. create bash file under root

root@docker101:~# nano createWorkdir.sh


```sh
#!/bin/bash

mkdir -p /root/autoBuild/ubuntu/1804
chmod -R 777 /root/autoBuild
touch /root/autoBuild/ubuntu/1804/dockerfile
chmod -R 755 /root/autoBuild/ubuntu/1804/dockerfile
cd /root/autoBuild/ubuntu/1804
```

root@docker101:~# chmod -R 755 createWorkdir.sh
root@docker101:~# ./createWorkdir.sh


## Step 2. copy this dockerfile to server.

root@docker101:~# nano /root/autoBuild/ubuntu/1804/dockerfile

```yml
FROM ubuntu:18.04
MAINTAINER Piboonsak Pimsarn (PiboonsakTraceon@gmail.com) 
LABEL Description="ubuntu 18.04 STD ver 1.0"
ENV ubuntu=18.04
RUN apt-get update && apt-get install -y \
	nano \
	vim \
	wget \
	curl \
	htop \
	man \
	net-tools \
        iptables iptables-persistent
RUN apt-get install -y iputils-ping
RUN apt-get install -y openssh-server
RUN service ssh restart
RUN mkdir -p /myapp
WORKDIR /myapp
EXPOSE 22/tcp 25/tcp 53/tcp 80/tcp 88/tcp 389/tcp 443/tcp 636/tcp 749/tcp \
1004/tcp 1006/tcp 2181/tcp 2377/tcp 3306/tcp 4732/tcp 6066/tcp 7077/tcp 7180/tcp \
8020/tcp 8070/tcp 8080/tcp 8485/tcp 8088/tcp 8888/tcp 8998/tcp 9083/tcp \
10000/tcp 11000/tcp 14000/tcp 18080/tcp 21050/tcp \
50020/tcp 50070/tcp 50470/tcp 50770/tcp 60010/tcp

```
------------------------------------------------------------------------------------------------------
## Step 3. Run bulid images.

`cd /root/autoBuild/ubuntu/1804`

`docker build .`

# Or
# use dock pull piboonsak/ubuntu:STD_18.04v2

`docker pull piboonsak/ubuntu:STD_18.04v2` # **Already up to docker hub**


## and run

docker run -dt --name preInstall2 \
--network cloudera --hostname preInstall2 \
--ip 177.10.10.12 \
-p 2022:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
ubuntu:STD_18.04v2


```
root@docker101:~# docker run -dt --name preInstall2 \
> --network cloudera --hostname preInstall2 \
> --ip 177.10.10.12 \
> -p 2022:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
> -p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
> -p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
> -p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
> -p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
> -p 18080:18080 -p 21050:21050 -p 23306:3306 \
> -p 50020:50020 -p 50070:50070 -p 50470:50470 \
> -p 50770:50770 -p 60010:60010 \
> ubuntu:STD_18.04v2
498bb4b850c1509e2a821ba64506ec44376ffe3868ef749172aa53d90a140664
root@docker101:~# docker container ls
CONTAINER ID        IMAGE                    COMMAND             CREATED             STATUS              PORTS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  NAMES
498bb4b850c1        ubuntu:STD_18.04v2       "/bin/bash"         5 seconds ago       Up 4 seconds        25/tcp, 0.0.0.0:80->80/tcp, 0.0.0.0:88->88/tcp, 0.0.0.0:389->389/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:636->636/tcp, 0.0.0.0:749->749/tcp, 0.0.0.0:1004->1004/tcp, 0.0.0.0:1006->1006/tcp, 53/tcp, 0.0.0.0:2181->2181/tcp, 0.0.0.0:4732->4732/tcp, 0.0.0.0:6066->6066/tcp, 0.0.0.0:7077->7077/tcp, 2377/tcp, 8020/tcp, 0.0.0.0:7180->7180/tcp, 0.0.0.0:8080->8080/tcp, 8070/tcp, 0.0.0.0:8088->8088/tcp, 8485/tcp, 0.0.0.0:8888->8888/tcp, 0.0.0.0:9083->9083/tcp, 0.0.0.0:10000->10000/tcp, 0.0.0.0:11000->11000/tcp, 0.0.0.0:14000->14000/tcp, 0.0.0.0:18080->18080/tcp, 0.0.0.0:21050->21050/tcp, 0.0.0.0:50020->50020/tcp, 0.0.0.0:50070->50070/tcp, 0.0.0.0:50470->50470/tcp, 0.0.0.0:50770->50770/tcp, 8998/tcp, 0.0.0.0:60010->60010/tcp, 0.0.0.0:2022->22/tcp, 0.0.0.0:23306->3306/tcp, 0.0.0.0:33306->3306/tcp   preInstall2
67db0c477907        portainer/agent:latest   "./agent"           9 days ago          Up 9 days


```

docker run -dt --name preInstall \
--network cloudera --hostname preInstall \
--ip 177.10.10.10 \
-p 2022:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
piboonsak/ubuntu:STD_18.04v2



root@preInstall:~# nano /etc/hosts
```
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

177.10.10.10    hd-c1nn     hd-c1nn.traceoncloud.com
177.10.10.11    hd-c2nn     hd-c2nn.traceoncloud.com
177.10.10.12    hd-c1dn1    hd-c1dn1.traceoncloud.com
177.10.10.13    hd-c1dn2    hd-c1dn2.traceoncloud.com
177.10.10.14    hd-c1dn3    hd-c1dn3.traceoncloud.com
177.10.10.15    hd-c1dn4    hd-c1dn4.traceoncloud.com
177.10.10.16    hd-c1dn5    hd-c1dn5.traceoncloud.com
```
## dowload cloudera 
download link : *http://archive.cloudera.com/cm5/installer/5.15.1.3/cloudera-manager-installer.bin*


wget http://archive.cloudera.com/cm5/installer/5.15.1.3/cloudera-manager-installer.bin


docker run -v /root:/mnt --hostname=quickstart.cloudera
--privileged=true -t -i -p 8888:8888 -p 8880:8880 -p
9092:9092 -p 2181:2181 -p 11122:11122
imcinstitute/analyticsplatform /usr/bin/docker-quickstart



docker run -dt --name hd-c1dn4 \
--network cloudera --hostname hd-c1dn4 \
--ip 177.10.10.15 \
-p 2022:22 -p 80:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /etc/hosts_cloudera : /etc/hosts \
-v .ssh : .ssh \
piboonsak/ubuntu:STD_18.04v2

.ssh/authorized_keys

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqoH+XieMvjaFA+nukEeLShGTqxlutB7mWz56Uzawh8oH0NK+YO0PPbIouMutNOXJrbjjCKdS1BwPZIEQx2xl1EyXWgO1XLTyU6u49a66n7+CeleCpK2eQp9enM6vIBNwHLOUXc6x+RcwEJCsfiLYXK9f5ikVbvzzRUkjH+5MmP2CquKHjSGO6BsQvj+wek09L1h/GzX1JjbyWRRL7tlnwIK2fR4Bp/vIyLCj4XK5LA5wU3hz885MozIywrmyADW90HocTSuxb+SobpphGIx/c6VZtwThZunw1mdri0nLheDZaoAbwlL67QZlib08GwsLJ5XAknLFHSb4YO9AEa6wn root@pibonsak-hp



nano .ssh/authorized_keys

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCom5tL7ER4KIzACAwomHJlSbPQC1Sa3WBFHmvIOvtKQTp4PzhhNoBKXOlqT6dAf4nJg/X55gySHMqv3AyIedGaaJThzloA7qzDGswEVqWU6bPAvv4tudnemHUamdlb5agsFEiVxKYX14qPnBPRNBVPVkI3xympPrebXsxHRzdekm5qzBGinRza6O76Kz70PbtadMQ4vAYUULjjS0rrQXUGDtV/SsOEz32WKhlf3+CZVhmzefUsybszAEMi+6R8eu+vUvM+jVw/7EjiACZteF/Y9nCsxbiT1cVHhswCQwnX1XTaTU+rokhkKvxWYMbK2QKk7GLqtUVkb+TTcVVP5PRR root@hd-c1nn
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wHwPuisBSpvjpoP6t5t0oOxf2vkrjZQ4O9cfJto/b2iGlagv9d1z983mTGTRUTQgogVMy+i9/3dtBgVp6Qu9KxvNx/g8Ai4rRk41TpNL/7tNy5d1C047y5LSmrxmxuDp7HRJ/pZO1syKkg+KZUWIQ4EI0KCOEZHYPf1kGxODATnJpvdblQTQ67Rn6JDW0beydW/J9RLHMJrKhB64WGZhhr0VODjdnimskWvGP6F+fk0ouwWWAebcJpYl3e5+9TheJiaz35OVLT5Imm2uKdBh4ZwPNPUBwk205vA6Bm4axOiZlc7APAuljRrBJ5tBl71lbZvd8GBGB+Bwd9LmNmVB root@hd-c2nn
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLlV6uhDoDQ25jPBQUkEOrO4OfIgKNbw9yBMPL6fHrTglQFFNgsGwEbGV3yIt4vwSuqeKP6J2EPgYM6Hnq4FbHZY/QyFXVM5tb5KFXxR9zGv2ZV9QySSw2geVfrOdb2B2KfHz9evV6QHGjZF+ScqMUdxQbm80mPQUy7mTNtaJTftJxjWsGt9XC+KoIuLPvcORtJaVI85iJKIliaWRVSF3C2quUmhGlqB132F21Bmg2UHeJyBA/X83xGasf8ntZxfbSll/p/dqhJvFBesIaSPcoLjpKtVwCJZVQREW4cqLak3dA69LpQHaUqp9N/JRDt+rPq6HfGbO3RR4kvNaaAbw9 root@hd-c1dn1
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0+flOnj+tbWlMg6txFvWfMcSxa5SiJz0iHShAv7klOjdth3r+p2pgyeEW/ensUFvhtjnrmGvtbdNTVWfNfdjLlH2pxpnz9IzcOOaGsV+jqs/F0D5WTEevVTwAjoAAP+tXYC/Pmwhasbx/kSdF79nKxQmwn/fAnQNtAiREOCKOnnhDQXhE2+RXQRYprtDIs/7KdIHLozlZn9EzR8Vrrvw+nQRNUF/EOgqaAFlXw6R3L/3BEK+tXmV6xrgCbwCo0HklB8au/swtdALdAeCO5Blg4NJd0tEjeF2sY9K3sHpTEFrHPDGcVIgZba8Wc+d90g32BhBgdI0qnyIMWTUJ1rlB root@hd-c1dn2
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRFheG3oMFFCYAesBYwsA86Q3tN9W8CWWbA0+xJy0hRnAKbvlwJGtQebFmYoVKW7Nj32IXLKue9zQfMEtWs6V3pMhPwInVFMsG0F9PqmEGaGj1mqhAs4piJcgfAy6avb8Sc2JS1wluSe+i4NXC+M+eyUkOl9Y3aLNNpGUJa1DpR+0oJaSVXJZRs4I8MQ9JdDWXFKF7Qu7+WkPtlGwLQecSTUqTsD01EHQsuUubYnLa3Nbzo9WhirCzR1mqD+JUoNKYXv47G49vMLKuj+/1GTmc1zZRtlf8wDRR8lDEbBIto3N30+WvdSx+kk5aPwypvKi8TqPqYZNe4eGmfam4DQFr root@hd-c1dn3
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgKkvyJhkAK0tr9yd+GZMEXDBjn/6BWfZTLR+zE5TUK5ZdJySV9+kiiBQFzv6z3ThXOdWeBMcJTUoceOtje8bIEeflsirS1jTb/V0DpxJ8Wlb0uSQTAwAkiG5E8MAQyIiLa5IzefZjy03kRYM5TSFEXKxFwclBuCAGOznGd2QNpXAHLDuGqhEj3cs8H9MxpNqgzeDvQseLrxW3Z7/33wtGSVPVOaz5wj8nxC8kfMPfCrGjbd6ukXW67JCZpN5eEDh/d6Fjlz9W2tHBErMC/Ly8WCpcWqeBPm61/TrPtW+eXBY00ExEg8wH85oOGJ/759rpwxVmy+VqSBHHZpKdVXo9 root@hd-c1dn4
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqoH+XieMvjaFA+nukEeLShGTqxlutB7mWz56Uzawh8oH0NK+YO0PPbIouMutNOXJrbjjCKdS1BwPZIEQx2xl1EyXWgO1XLTyU6u49a66n7+CeleCpK2eQp9enM6vIBNwHLOUXc6x+RcwEJCsfiLYXK9f5ikVbvzzRUkjH+5MmP2CquKHjSGO6BsQvj+wek09L1h/GzX1JjbyWRRL7tlnwIK2fR4Bp/vIyLCj4XK5LA5wU3hz885MozIywrmyADW90HocTSuxb+SobpphGIx/c6VZtwThZunw1mdri0nLheDZaoAbwlL67QZlib08GwsLJ5XAknLFHSb4YO9AEa6wn root@pibonsak-hp


service ssh restart

`docker save -o /root/images/ubuntu_1604_stdv2.tar ubuntu:STD_16.04v2`

root@docker100:~/ClouderaOnDocker/src/bash# docker save -o /root/images/ubuntu_1604_stdv2.tar ubuntu:STD_16.04v2

or
docker pull piboonsak/ubuntu:STD_16.04v2


/root/ClouderaOnDocker/src/bash/createhost.sh


FROM ubuntu:16.04
MAINTAINER Piboonsak Pimsarn (PiboonsakTraceon@gmail.com) 
LABEL Description="ubuntu 16.04 STD ver 1.0"
ENV ubuntu=16.04
RUN apt-get update && apt-get install -y \
	nano \
	sudo \
	vim \
	wget \
	curl \
	htop \
	man \
	net-tools \
        iptables iptables-persistent
RUN apt-get install -y iputils-ping
RUN apt-get install -y openssh-server
RUN service ssh restart
RUN mkdir -p /root/.ssh
EXPOSE 22/tcp 25/tcp 53/tcp 80/tcp 88/tcp 389/tcp 443/tcp 636/tcp 749/tcp \
1004/tcp 1006/tcp 2181/tcp 2377/tcp 3306/tcp 4732/tcp 6066/tcp 7077/tcp 7180/tcp \
8020/tcp 8070/tcp 8080/tcp 8485/tcp 8088/tcp 8888/tcp 8998/tcp 9083/tcp \
10000/tcp 11000/tcp 14000/tcp 18080/tcp 21050/tcp \
50020/tcp 50070/tcp 50470/tcp 50770/tcp 60010/tcp
CMD ["ssh","start"]

docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/secret/authorized_keys:/root/.ssh/authorized_keys \
-v /root/ClouderaOnDocker/src/bash/secret/hd-c1nn-key.pub:/root/.ssh/id_rsa.pub \
ubuntu:STD_16.04v3


docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2022:22 -p 81:80 -p 88:88 -p 389:389 -p 443:443 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 \
-p 2181:2181 -p 33306:3306 -p 4732:4732 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 8080:8080 -p 8888:8888 -p 8088:8088 \
-p 9083:9083 -p 10000:10000 -p 11000:11000 -p 14000:14000 \
-p 18080:18080 -p 21050:21050 -p 23306:3306 \
-p 50020:50020 -p 50070:50070 -p 50470:50470 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
ubuntu:STD_16.04v3


## hd-c2nn

scp -r /root/ClouderaOnDocker/ docke101:/root

## Build images and tag name image

`docker build -t ubuntu:STD_16.04v4 .`

```
root@docker100:~/ClouderaOnDocker/src/dockerfile/ubuntu1604# docker build -t ubuntu:STD_16.04v4 .
```

root@docker100:~/ClouderaOnDocker/src/dockerfile/ubuntu1604# docker build --help

Usage:	docker build [OPTIONS] PATH | URL | -

Build an image from a Dockerfile

Options:
      --add-host list           Add a custom host-to-IP mapping (host:ip)
      --build-arg list          Set build-time variables
      --cache-from strings      Images to consider as cache sources
      --cgroup-parent string    Optional parent cgroup for the container
      --compress                Compress the build context using gzip
      --cpu-period int          Limit the CPU CFS (Completely Fair Scheduler) period
      --cpu-quota int           Limit the CPU CFS (Completely Fair Scheduler) quota
  -c, --cpu-shares int          CPU shares (relative weight)
      --cpuset-cpus string      CPUs in which to allow execution (0-3, 0,1)
      --cpuset-mems string      MEMs in which to allow execution (0-3, 0,1)
      --disable-content-trust   Skip image verification (default true)
  -f, --file string             Name of the Dockerfile (Default is 'PATH/Dockerfile')
      --force-rm                Always remove intermediate containers
      --iidfile string          Write the image ID to the file
      --isolation string        Container isolation technology
      --label list              Set metadata for an image
  -m, --memory bytes            Memory limit
      --memory-swap bytes       Swap limit equal to memory plus swap: '-1' to enable unlimited swap
      --network string          Set the networking mode for the RUN instructions during build (default "default")
      --no-cache                Do not use cache when building the image
      --pull                    Always attempt to pull a newer version of the image
  -q, --quiet                   Suppress the build output and print image ID on success
      --rm                      Remove intermediate containers after a successful build (default true)
      --security-opt strings    Security options
      --shm-size bytes          Size of /dev/shm
  -t, --tag list                Name and optionally a tag in the 'name:tag' format
      --target string           Set the target build stage to build.
      --ulimit ulimit           Ulimit options (default [])


### root passwd

RUN echo "root:Docker!" | chpasswd
RUN echo "root:123456" | chpasswd


######################################## Usually Command #####################################################

### Clear all Container and Repository

`./clearClouderaContainer.sh | ./removeHostRepository.sh`

```
root@docker100:~/ClouderaOnDocker/src/bash# ./clearClouderaContainer.sh | ./removeHostRepository.sh

```

### run create cloudera hosts

 `./createConfigSecret.sh`

 `./runCreateClouderaHosts.sh`

#### Ver 2-3
`./createConfigSecret.sh | ./runCreateClouderaHostsv2.sh`

`./createConfigSecret.sh | ./runCreateClouderaHostsv3.sh`
##############################################################################################################

### Struck ssh key can't add in -v option
**Maybe create in container**

## Run cli

```
service ssh start
ssh-keygen
touch .ssh/authorized_keys
cat .ssh/id_rsa.pub > .ssh/authorized_keys
```

.ssh/authorized_keys


ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZiQP0Qk3T5HOXvQfmrgtVKoxclznG1NPxS0Pg/YeHQMMNZPHWsVZGhGgjmGrHXLJ/GbnxhwjWE+TmjLBnCm8rgjDEIdQSu455gxkK0xMVFjyWk/p4dSBAhoUU1N1MiIXCAAft0H6CjDaeLKdc7u9VwBWdNeU0ZABF/rp5ucncG7jj3qAnZ1cF7tQ1F8k2R7KZiMmR+ZrhoxDy1v+cH/5RH7pN91VtAqnwZ/O4xaJZrY6mOGdhKQ7HHD2wXaBXAY0rVlCNnywGhAXHsDaNkKWKRqc/bYeP9EprmMkClhqvAk884XuUBqkNaTuAIjvMHh55TGgJ3ioNHqEPezgLe62H root@hd-c1nn
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSrDK/lC5GG0XGrz8LaMacVE4KmAUuRDwdn34I47faSNm7LaaXgMgOfm4g88SUx5RPcbPG8TyhJcFrzy8464OpwfVO8Vk+ptt15MNwOPCRujmlgsmNL0VbMvSqmNHIaTANmOTbtoJxCK1udG29F7m6h8GbceEITi1LTngYVcfT1XQG0a46RQXdffCf3RlYeZcBPtUAPOw5udJNukynXgr5pQRhZTqPJiQDsW36bGezd2mTpNiIBneSp/hUXSTf37a3JB8jx7aYD09CykALH2XEzPX4j1MAFcHoLMNB9MB2VIXdc9djO86+hduS/yiHoVWcWdf/5p1VFomcGJ4UARdl root@hd-c2nn
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgIZtnVzeJLqL2OW9D+LueiUpEWmNucs+9VCV96iO8Clqma1qLvz/96FKgGcMInPVDQt+2C4QaxAklskSIKTNDq/1Y38R1l1FKL262wSYIOItjAo9N/NPe+xhdwOuIuULAEH/oixwmcsQ1QV2veF2p52Np9DcJ8+ES/s1jYzXLaPAe+4UxHzXQEuCykZ6vRT8jKLns4auBZfHYmwZAZHDmz5fuO62er2kZouNxxpsD0xx8SItAozgQnSUvHVv16uhYdWt4MModgt8JTlhEuEAQyxtQ6Dp69HqYEh1jzijTbvuHR9WbXneq6VL4aIvZ/9bDvrLw28m6wK7QGpKXHOUX root@hd-c1dn1
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7rIQww3bpIsh+BAWZHcBw8TpzvBk3u3OS7Fc0hpKSAwgyV+FuMBjkxFhjaYvgg41FMnfDQN0RBeQ3KqUoZcvhqCQP322Wrcmi133IA6F4epLCWnU5fnTaZ3+Z9xOXwU0vr2d4Phnihw3jbakWPCwGpFPIRx9eI7jDds2TP2U0UJCx5cO2hxpyhAt39//8mV59+Zt6JTF1G1511AwNnaDwKRUQiQe0l5ubc9gT+tSuG7tpbf9KVT1oe578H2+X1TfFmdwTRcHpYQUYDFEXvkhdBqzmN4CZgSGKs5+1OeAW3Q2XPpRbp97fwT4h+VVUNV1GgZw3tWNh0KKFbu04G407 root@hd-c1dn2
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDo1nGj9g0GbDgDDZp/Mmlf1g5nqUdrjgD+ZoV5YffdLU8MNloi8bHcZDTGb+xZI3sOmPmgNfwo7aG8RApRwGc6jlGqm3Mj6cVdUiF7Ds5VH79Tx8Fkg77zO8nOgVKyH/BEtvteun/eb9p2jsbpVeQ7D7aR/rQ3JX9s7/FJukwWni5MgGfkN/8oMCoTIxvqeUraNI9maM7uH9D7F8+GvqV8VD23cLoL0wQfeL/Nn8kCncQrl+rFBhApmumkcR5oHsTQV98lWms3W6D++ifYIAfi1OfJ8sdEl8MijazbrEeNouFt9mB7kqFE2RdVMItJPvBFiRMSrQ6AV9mKG9vhqOg3 root@hd-c1dn3
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMvdO/1mHY1kEtXCGPgfsTI8tngyEa5O980QkODL5msyhzpVgaMeRkAm0fDLHZB5njsuKlI8shysu1mEHs6rltIvi7E8u1RzEG9LaJ4KsuA5Hm0wPgDtX5trpcYaD3dKEMX8WNbxo53ltOjLCoiwDgHqXM3Fw9eGmmXCy4fzORak7VW9TdeOQxVHhNFo0lTFUClrWoNUNp231yyd9pEfpA1V71xm0wMxQXSpqhJ1+mtbW6U1CgxtUHrpfnhCaQJJkin8Ni7MJ0yLNaUIz1k3F1fbPEG5WUM4yDDcQjuEKEVonvRrPLZQTN4n99mlTZPdVuBD/BqGRB1jL5DEWnOlNT root@hd-c1dn4
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDD06tt7GLbQf1a/DtPp0GekhHlS1Y+CrDhB45af7gHhk+KZPWNKpxPmxLqpppDxQ/8rxJwTB3qDRRqTLzeQ8J/gsb+ywAbno8yKdvHHp4XQz7IGcCHxIM4HUSxkEN3JixoacAGluOFMguzNLRfvX/lGTZd3hm1H8lyy8gAKzkPS6RlCwzMJyylVU8qP4iCHyGMZUHCQPjdH9sBoz1Fg0MyEvz2qRCLY+/x1QWR9xL3zHkhl6rJsmeinB2sKvBD5Gq72Mmy6S0DamN6EV7azyy7eL4uvMA+TutqWtTygbB/FPvtUdNF7nnvPwvQGZJIc8bZmhC3WTgAYm4aJSp4DgkZ root@docker100
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqoH+XieMvjaFA+nukEeLShGTqxlutB7mWz56Uzawh8oH0NK+YO0PPbIouMutNOXJrbjjCKdS1BwPZIEQx2xl1EyXWgO1XLTyU6u49a66n7+CeleCpK2eQp9enM6vIBNwHLOUXc6x+RcwEJCsfiLYXK9f5ikVbvzzRUkjH+5MmP2CquKHjSGO6BsQvj+wek09L1h/GzX1JjbyWRRL7tlnwIK2fR4Bp/vIyLCj4XK5LA5wU3hz885MozIywrmyADW90HocTSuxb+SobpphGIx/c6VZtwThZunw1mdri0nLheDZaoAbwlL67QZlib08GwsLJ5XAknLFHSb4YO9AEa6wn root@pibonsak-hp


## language problem

sudo apt-get install language-pack-en

locale-gen en_US.UTF-8

root@hd-c2nn:~# locale-gen en_US.UTF-8
Generating locales (this might take a while)...
  en_US.UTF-8... done
Generation complete.

locale -a

root@hd-c2nn:~# locale
LANG=
LANGUAGE=
LC_CTYPE="POSIX"
LC_NUMERIC="POSIX"
LC_TIME="POSIX"
LC_COLLATE="POSIX"
LC_MONETARY="POSIX"
LC_MESSAGES="POSIX"
LC_PAPER="POSIX"
LC_NAME="POSIX"
LC_ADDRESS="POSIX"
LC_TELEPHONE="POSIX"
LC_MEASUREMENT="POSIX"
LC_IDENTIFICATION="POSIX"
LC_ALL=
root@hd-c2nn:~# 


root@hd-c2nn:~# cat /etc/default/locale
#  File generated by update-locale

sudo locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8

sudo locale-gen en_US.UTF-8 | update-locale LANG=en_US.UTF-8

update-locale LC_ALL=en_US.UTF-8
LC_NUMERIC=th_TH.UTF-8
LC_TIME=th_TH.UTF-8

	LANGUAGE = (unset),
	LC_ALL = (unset),
	LC_TIME = "th_TH.UTF-8",
	LC_MONETARY = "th_TH.UTF-8",
	LC_ADDRESS = "th_TH.UTF-8",
	LC_TELEPHONE = "th_TH.UTF-8",
	LC_NAME = "th_TH.UTF-8",
	LC_MEASUREMENT = "th_TH.UTF-8",
	LC_IDENTIFICATION = "th_TH.UTF-8",
	LC_NUMERIC = "th_TH.UTF-8",
	LC_PAPER = "th_TH.UTF-8",
	LANG = "en_US.UTF-8"
-----------------------------------------------------------------------------------------------------------
## install JAVA JDK

apt-get update && apt-get upgrade
apt-get install default-jdk

root@hd-c2nn:~# java -version
openjdk version "1.8.0_181"
OpenJDK Runtime Environment (build 1.8.0_181-8u181-b13-0ubuntu0.16.04.1-b13)
OpenJDK 64-Bit Server VM (build 25.181-b13, mixed mode)
root@hd-c2nn:~# javac -version
javac 1.8.0_181


root@hd-c2nn:~# update-alternatives --config java
There is only one alternative in link group java (providing /usr/bin/java): /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
Nothing to configure.

sudo apt-get install oracle-j2sdk1.8


-p 2221:21 -p 2222:22 -p 2225:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464\
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 


https://archive.cloudera.com/cm6/6.0.0/ubuntu1604/apt/cloudera-manager.list
http://archive.cloudera.com/cm5/cm/5/cloudera-manager-xenial-cm5.15.0_amd64.tar.gz
https://archive.cloudera.com/cm5/ubuntu/xenial/amd64/cm/dists/xenial-cm5.15.1/InRelease

--------------------------------------------------------------------------------------------------------
## install Oracle JDK
apt-get update && apt-get upgrade

apt-get install -y software-properties-common

add-apt-repository -y ppa:webupd8team/java
apt update; apt-get install -y oracle-java8-installer
update-alternatives --config java
java -version
javac -version


root@hd-c1nn:~# update-alternatives --config java
There are 2 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                            Priority   Status
------------------------------------------------------------
  0            /usr/lib/jvm/java-8-oracle/jre/bin/java          1081      auto mode
  1            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode
* 2            /usr/lib/jvm/java-8-oracle/jre/bin/java          1081      manual mode

Press <enter> to keep the current choice[*], or type selection number: 2


root@hd-c1nn:~# java -version
java version "1.8.0_181"
Java(TM) SE Runtime Environment (build 1.8.0_181-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.181-b13, mixed mode)
root@hd-c1nn:~#


apt-get install -y host

apt-get install -y apt-transport-https

wget -qO- -T 1 -t 1 http://169.254.169.254/latest/meta-data/public-hostname && /bin/echo



FROM ubuntu:16.04
MAINTAINER Piboonsak Pimsarn (PiboonsakTraceon@gmail.com)
LABEL Description="ubuntu 16.04 STD ver 5.0"
ENV ubuntu=16.04
RUN apt-get update && apt-get install -y \
        nano \
        sudo \
        vim \
        wget \
        curl \
        htop \
        man \
        host \
        net-tools \
        iptables iptables-persistent \
        apache2 \
        software-properties-common \
        apt-transport-https
RUN apt update && apt-get install -y oracle-java8-installer
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get install -y iputils-ping
RUN apt-get install -y openssh-server
RUN apt-get update
RUN rm -rf /var/lib/apt/lists/*
RUN echo "root:123456" | chpasswd
RUN service apache2 start
RUN service ssh start
RUN mkdir -p /root/.ssh
EXPOSE 22/tcp 25/tcp 53/tcp 80/tcp 88-2200/tcp \
3000-3400/tcp 4000-4800/tcp 5000-6100/tcp 7000-7500/tcp \
8000-8100/tcp 8800-9200/tcp 9800-10200/tcp 14000-16200/tcp \
18000-20000/tcp 21000-26000/tcp 41414/tcp 50000-51000/tcp 60010/tcp



EXPOSE 22/tcp 25/tcp 53/tcp 80/tcp 88-2200/tcp \
3000-3400/tcp 4200-4800/tcp 5500-6100/tcp 7000-7500/tcp \
8000-8100/tcp 8800-9200/tcp 9800-10200/tcp 14000-16200/tcp \
18000-20000/tcp 21000-26000/tcp 41414/tcp 50000-51000/tcp 60010/tcp


EXPOSE 22/tcp 25/tcp 53/tcp 80/tcp 88-2200/tcp \
3000-3400/tcp 4200-6100/tcp 7000-7500/tcp \
8000-10200/tcp 14000-16200/tcp \
18000-26000/tcp 41414/tcp 50000-51000/tcp 60010/tcp



docker run -it -p 7100-7120:7100-7120/tcp 

-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \



-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464\
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 



# Image piboonsak/ubuntu:STD_16.04v5

FROM ubuntu:16.04
MAINTAINER Piboonsak Pimsarn (PiboonsakTraceon@gmail.com)
LABEL Description="ubuntu 16.04 STD ver 5.0"
ENV ubuntu=16.04
RUN apt-get update && apt-get install -y \
        nano \
        sudo \
        vim \
        wget \
        curl \
        htop \
        man \
        host \
        language-pack-en \
        net-tools \
        iptables iptables-persistent \
        software-properties-common \
        apt-transport-https
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN apt-get install -y iputils-ping
RUN apt-get install dnsutils -y
RUN apt-get install -y openssh-server
RUN apt-get update
RUN rm -rf /var/lib/apt/lists/*
RUN echo "root:123456" | chpasswd
RUN service ssh start
RUN mkdir -p /root/.ssh
EXPOSE 22 25 53 80 88-220 \
3000-3400 4000-4800 5000-6100 7000-7500 \
8000-8100 8800-9200 9800-10200 14000-16200 \
18000-20000 21000-26000 41414 50000-51000 60010



RUN add-apt-repository -y ppa:webupd8team/java
RUN service apache2 start
RUN apt update && apt-get install -y oracle-java8-installer



wget https://archive.cloudera.com/cm6/6.0.0/cloudera-manager-installer.bin

docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2021:21 -p 2022:22 -p 2225:25 -p 81:80 \
-p 88-2200:88-2200/tcp -p 3268:3268 -p 3269:3269 -p 33306:3306 \
-p 4242:4242 -p 4732:4732 -p 55432:5432 -p 5678:5678 -p 6066:6066 \
-p 7000-7500:7000-7500/tcp -p 8000-10200:8000-10200/tcp \
-p 14000-16200:14000-16200/tcp -p 18000-26000:18000-26000/tcp \
-p 41414:41414 -p 50000-51000:50000-51000/tcp -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5



docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5


docker run -dt --name hd-c2nn \
--network cloudera --hostname hd-c2nn \
--ip 177.10.10.11 \
-p 2021:21 -p 2022:22 -p 2025:25 -p 81:80 -p 88:88 -p 111:111 -p 389:389 -p 4443:443 -p 464:464 \
-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
-p 8020:8020 -p 8022:8022 -p 8080:8080 -p 8032:8032 -p 8033:8033 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 8888:8888 -p 8088:8088 -p 9000:9000 -p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
-p 10000:10000 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \
-p 14000:14000 -p 14001:14001 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
-p 50020:50020 -p 50070:50070 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 -p 60010:60010 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5


docker run -dt --name hd-c1nn \
--network cloudera --hostname hd-c1nn \
--ip 177.10.10.10 \
-p 2021:21 -p 2022:22 -p 2225:25 -p 81:80 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
piboonsak/ubuntu:STD_16.04v5


## Deploy DB for cloudera
docker run -dt --name mysql \
--network cloudera --hostname mysql \
--ip 177.10.10.206 \
-p 22222:22 -p 53306:3306 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/:/etc/mysql \
piboonsak/ubuntu:STD_16.04v5

apt-get update && apt-get upgrade

###  install ssh-keygen

step 1. install ssh-keygen

```
service ssh start

ssh-keygen -q -N '' -f /root/.ssh/id_rsa

ssh-copy-id -n -f root@hd-c2nn

ssh hd-c2nn

```

root@hd-c2nn:~# ssh-copy-id -n -f root@hd-c1nn
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
=-=-=-=-=-=-=-=
Would have added the following key(s):

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCySz5+uNZ75/SVQTGzpIbW4PbnE9ZCI0FJeJezFT35VV9jz/EC0PNaEX0DV1fE/iuf3I9zcbU9OVG2pnK0iKLkams/uHb8HNcsFt83drekJOgNqopT/mNnhdDTgWFVXSHr1P8MaYz4YN7cf5XMs2Wagt4nhMgj826eef+rVizSfTJ02mjhN225nFUDjh4LR+U3LfjNcZZmqxWsmfRr4MIZ5EL5Z+eS9ahW46IzSBGtzxg8tbjw+QyOLLAMGxD2QGsn5ODzvrA+UkADXFj7T/ABz9llwEnHns91sLv3j1TXit2045i/DaacxcrH+AemrP/vQujPeq4KLoywOZV4Ey/h root@hd-c2nn
=-=-=-=-=-=-=-=


cat .ssh/id_rsa.pub > .ssh/authorized_keys

step 2. install cloudera manager

sudo sysctl -a |grep 'vm.swapp*\|vm.over*'

root@hd-c1nn:~# sudo sysctl -a |grep 'vm.swapp*\|vm.over*'
sysctl: reading key "kernel.unprivileged_userns_apparmor_policy"
sysctl: reading key "net.ipv6.conf.all.stable_secret"
sysctl: reading key "net.ipv6.conf.default.stable_secret"
sysctl: reading key "net.ipv6.conf.eth0.stable_secret"
sysctl: reading key "net.ipv6.conf.eth1.stable_secret"
sysctl: reading key "net.ipv6.conf.lo.stable_secret"
vm.overcommit_kbytes = 0
vm.overcommit_memory = 0
vm.overcommit_ratio = 50
vm.swappiness = 60


scp /root/ClouderaOnDocker/src/bash/input_hd-c2nn_SSHKey.sh docker101:/root

#!/bin/bash
#ssh-copy-id root@hd-c1nn
ssh-copy-id root@hd-c2nn
ssh-copy-id root@hd-c1dn1
ssh-copy-id root@hd-c1dn2
ssh-copy-id root@hd-c1dn3
ssh-copy-id root@hd-c1dn4



## Download JDK

wget http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-i586.tar.gz

## Download cloudera ver 5.15.0.7

http://archive.cloudera.com/cm5/installer/5.15.0/cloudera-manager-installer.bin


tree -a /var/run/cloudera-scm-Agent/process/879-hdfs-NAMENODE/ 
/var/run/cloudera-scm-Agent/process/879-hdfs-NAMENODE/

http://gitlab/Developer/traceon.oneapp.master.restapi/repository/master/archive.tar.gz

http://gitlab/TRACEON_DEVELOPMENT/BIG_DATA/ClouderaOnDocker/repository/master/archive.tar.gz



-v /root/ClouderaOnDocker/src/cloudera-manager-installer.bin:/root/cloudera-manager-installer.bin \
-v /root/ClouderaOnDocker/src/jdk-8u144-linux-i586.rpm:/root/jdk-8u144-linux-i586.rpm \
-v /root/ClouderaOnDocker/src/jdk-8u144-linux-i586.tar.gz:/root/jdk-8u144-linux-i586.tar.gz \


scp jdk-8u144-linux-i586.rpm jdk-8u144-linux-i586.tar.gz docker101:/root

ssh docker101 ls -lah /root/


root@hd-c2nn:~# cat .ssh/id_rsa.pub > .ssh/authorized_keys 
root@hd-c2nn:~# ssh hd-c1dn1 cat .ssh/id_rsa.pub >> .ssh/authorized_keys 



docker exec -it hd-c2nn /bin/sh -c cat .ssh/id_rsa.pub > .ssh/authorized_keys



RUN apt-get update && apt-get install -y \
language-pack-en net-tools iptables iptables-persistent python-software-properties apt-transport-https

## List importance port

-p 2022:22 -p 81:80 -p 88:88 -p 4443:443 -p 8020:8020 -p 8022:8022 -p 8032:8032 \
-p 8033:8033 -p 8080:8080 -p 8088:8088  -p 8888:8888  \
-p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 7180:7180 -p 7182:7182 -p 7183:7183 -p 7184:7184 -p 7185:7185 \
-p 10000:10000 -p 14000:14000 -p 14001:14001 \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
-p 50020:50020 -p 50070:50070 -p 60010:60010 \



-p 636:636 -p 749:749 -p 1004:1004 -p 1006:1006 -p 1521:1521 -p 2181:2181 -p 2049:2049 \
-p 3268:3268 -p 3269:3269 -p 33306:3306 -p 4242:4242 -p 4732:4732 \
-p 55432:5432 -p 5678:5678 -p 6066:6066 -p 7077:7077 \
-p 7186:7186 -p 7187:7187 -p 7190:7190 -p 7191:7191 -p 7432:7432 \
 -p 8042:8042 -p 8044:8044 \
-p 8083:8083 -p 8084:8084 -p 8086:8086 -p 8087:8087 -p 8089:8089 -p 8090:8090 -p 8091:8091 \
-p 9083:9083 -p 9090:9090 -p 9091:9091 \
-p 9864:9864 -p 9865:9865 -p 9866:9866 -p 9867:9867 -p 9870:9870 -p 9871:9871 \
-p 9994:9994 -p 9995:9995 -p 9996:9996 -p 9997:9997 -p 9998:9998 -p 9999:9999 \
 -p 10002:10002 -p 10101:10101 -p 10110:10110 -p 10111:10111 -p 11000:11000 -p 11060:11060 \

-p 18080:18080 -p 19001:19001 -p 19888:19888 -p 19890:19890 \
-p 21000:21000 -p 21050:21050 -p 20550:20550 -p 25000:25000 -p 25010:25010 -p 41414:41414 \
 -p 50079:50079 -p 50470:50470 -p 50579:50579 -p 50111:50111 \
-p 50770:50770 \


https://archive.cloudera.com/cdh5/parcels/5.12.0/
https://archive.cloudera.com/cdh4/parcels/latest/
https://archive.cloudera.com/impala/parcels/2.0.0/
https://archive.cloudera.com/accumulo/parcels/1.4/
https://archive.cloudera.com/accumulo-c5/parcels/latest/
https://archive.cloudera.com/kafka/parcels/3.0/
http://archive.cloudera.com/kudu/parcels/5.12/
https://archive.cloudera.com/spark/parcels/latest/
https://archive.cloudera.com/sqoop-connectors/parcels/latest/



-v /root/ClouderaOnDocker/src/bash/secret/createAuthorizedKey.sh:/root/createAuthorizedKey.sh

-v /root/ClouderaOnDocker/src/bash/config/resolv_dc-os.conf:/etc/resolv.conf



clearClouderaContainer.sh  createhost.sh                runCreateClouderaHostsv3.sh       secret
commitAndPushImages.sh     createnetwork.sh             runCreateClouderaHostsv4.sh       setSecureKeys.sh
commitImages.sh            inputC1nnSSKey.sh            runCreateClouderaHostsv5.sh       setSecureKeysPath2.sh
commitImages.sh.save       listClouderaContainer.sh     runCreateClouderaHostsv5.sh.save  setSecureKeysv2.sh
config                     removeHostRepository.sh      runCreateClouderaHostsv6.sh
createConfigSecret.sh      runCreateClouderaHosts.sh    runLoadpreInstallImage.sh
createUbuntuimage.sh       runCreateClouderaHostsv2.sh  runService.sh




https://archive.cloudera.com/cm5/ubuntu/xenial/amd64/cm/dists/xenial-cm5.15.1



F36A89E33CC1BD0F71079007327574EE02A818DD

hd-c1dn[1-4]


root@hd-c1dn1:~# apt-get update


apt-get update
apt-get -y install apt-transport-https

apt-get update



docker build -t ubuntu:oracleJDK8 .

root@docker105:~# docker volume ls
DRIVER              VOLUME NAME
local               elk_data
local               testMysql


docker run -dt --name testMysql \
--network cloudera --hostname testMysql \
--ip 177.10.10.207 \
-p 20222:22 -p 63306:3306 \
-v /root/ClouderaOnDocker/src/bash/config/hosts_cloudera:/etc/hosts \
-v /root/ClouderaOnDocker/src/bash/config/resolv_local.conf:/etc/resolv.conf \
-v /root/ClouderaOnDocker/src/bash/config/ssh_config:/etc/ssh/ssh_config \
-v /root/ClouderaOnDocker/src/bash/config/mysql:/etc/mysql \
-v testMysql:/var/lib/mysql \
piboonsak/ubuntu:mysqlv5.7.23
--------------------------------------------------------------------------------------------

ulimit –l
root@hd-c1nn:~# ulimit -l
64
root@hd-c1nn:~#  free -h
              total        used        free      shared  buff/cache   available
Mem:            15G        5.2G        445M        215M         10G        9.8G
Swap:          979M        175M        804M
root@hd-c1nn:~# ulimit -l
64

man 2 getrlimit

root@hd-c1nn:~# nano /etc/security/limits.conf
add text to file
# allow user 'root' mlockall

*                hard    memlock         unlimited
*                soft    memlock         unlimited


root@hd-c1nn:~#   ulimit -l
64
root@hd-c1nn:~#   ulimit -a
core file size          (blocks, -c) unlimited
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 64013
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1048576
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) unlimited
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
root@hd-c1nn:~# 

65536

## login cmf
http://192.168.23.100:7180/cmf/login

hd-c[1-2]nn
hd-c1dn[1-4]

root@docker100:~/ClouderaOnDocker# iftop
interface: ens160
IP address is: 192.168.23.100
MAC address is: 00:50:56:ae:7b:a5
root@docker100:~/ClouderaOnDocker#


docker run --ulimit memlock=819200000:819200000 -h <docker_host_name> --name=current -v /home/user_home:/user_home -i -d -t docker_user_name/image_name


## ulimit problem!.
**run on docker host then restart docker service**
reflink : https://stackoverflow.com/questions/24961576/docker-error-while-creating-couchbase-ulimit-open-files-cannot-modify-limit
ulimit -l unlimited


```sh
Last login: Wed Oct 24 09:39:45 2018 from 192.168.23.100
root@docker105:~# ulimit -l unlimited
root@docker105:~# ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 64028
max locked memory       (kbytes, -l) unlimited
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 64028
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

```

## In container
```
root@e4fb60345069:~# ulimit -l
64
root@e4fb60345069:~# ulimit -l unlimited
bash: ulimit: max locked memory: cannot modify limit: Operation not permitted
root@e4fb60345069:~# nano .bashrc 
root@e4fb60345069:~# 
root@e4fb60345069:~# source .bashrc 
bash: ulimit: max locked memory: cannot modify limit: Operation not permitted
root@e4fb60345069:~# ulimit -l unlimited
bash: ulimit: max locked memory: cannot modify limit: Operation not permitted

```

# Set ulimit memlock
ulimit -l unlimited

docker run -dt --ulimit --name testmemlock memlock=32768:32768 piboonsak/ubuntu:mysqlv5.7.23 sh -c "ulimit -a"

docker run -dt --name testmemlock --ulimit memlock=16777216:16777216 piboonsak/ubuntu:mysqlv5.7.23

docker run -dt --name testmemlock --ulimit memlock=33554432:33554432 piboonsak/ubuntu:mysqlv5.7.23

16 gb = 17179869184 bytes
32 gb = 34359738368 bytes

docker run -dt --name testmemlock --ulimit memlock=17179869184:17179869184 --memory-swappiness=0 piboonsak/ubuntu:mysqlv5.7.23

docker run -dt --name testmemlock --ulimit memlock=34359738368:34359738368 --memory-swappiness=0 piboonsak/ubuntu:mysqlv5.7.23

# run by --privileged it! work!!
--privileged

docker run -dt --name testmemlock --privileged piboonsak/ubuntu:mysqlv5.7.23

**But not suitable because it'll gone went exit container**


# Set swappiness
sysctl vm.swappiness=10

or 
edit file /etc/sysctl.conf
add
vm.swappiness = 10

### Check by
cat /proc/sys/vm/swappiness



--memory-swappiness=0 
docker run -dt --name testmemlock --ulimit memlock=33554432:33554432 --memory-swappiness=0 piboonsak/ubuntu:mysqlv5.7.23


dfs.datanode.max.locked.memory 986710016 bytes

de's available RLIMIT_MEMLOCK ulimit of 33554432 bytes



--memory-swappiness=10


docker run -dt --name testmemlock \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:mysqlv5.7.23 sh -c ulimit -l unlimited


docker run -dt --name testmemlock \
--ulimit memlock=34359738368:34359738368 --memory-swappiness=0 --privileged \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:mysqlv5.7.23 sh -c 'ulimit -l unlimited'

docker exec -it --privileged testmemlock sh -c 'ulimit -l unlimited'


## It's work!!!
docker run -dt --name testmemlock \
--ulimit memlock=-1 --memory-swappiness=0 --privileged \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:mysqlv5.7.23


docker exec -it testmemlock bash


docker run -dt --name testmemlock \
--ulimit memlock=-1 --memory-swappiness=0 \
-v /root/ClouderaOnDocker/src/bash/config/limits.conf:/etc/security/limits.conf \
piboonsak/ubuntu:mysqlv5.7.23


docker run -dt --name testmemlock \
--ulimit memlock=-1 --memory-swappiness=0 \
piboonsak/ubuntu:mysqlv5.7.23


<h3>Memory config</h3>
<img src="doc/img/Selection_296.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

<h3>JAVA Heap size config</h3>
<img src="doc/img/Selection_296.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

<br>
<img src="doc/img/Selection_296.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

<br>
<img src="doc/img/Selection_296.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />



















