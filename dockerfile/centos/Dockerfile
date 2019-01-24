FROM centos:7

MAINTAINER TraceonCloud
LABEL name=CentOS vendor=CentOS license=GPLv2 build-date=20181204

RUN yum clean all && yum update -y && yum clean all && rpm --rebuilddb
ONBUILD RUN yum clean all && yum update -y && yum clean all && rpm --rebuilddb
RUN yum clean all && yum update -y && yum clean all && rpm --rebuilddb

ENV HOME=/root
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ENV JAVA_HOME=/usr/lib/jvm/jre-openjdk
RUN yum install -y java-1.8.0-openjdk && yum clean all
ONBUILD RUN eval "${YUM_CMD} || ${YUM_CMD}"

ENV HOME=/root
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN eval "${YUM_CMD} || ${YUM_CMD}"
ENV JAVA_HOME=/usr/lib/jvm/jre-openjdk

ENV container docker

RUN yum  update -y;\
yum install -y openssh-server;\
yum install -y openssh-clients;\
yum install -y net-tools;\
yum install -y nano;\
yum install -y curl;\
yum install -y net-tools;\
yum install -y sudo;\
yum install -y epel-release;

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 22/tcp

CMD ["/bin/bash"]
