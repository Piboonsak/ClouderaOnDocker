# Ubuntu dockerfile

## Install JDK 8 
RUN apt-get --quiet update && \
    apt-get --quiet --yes install wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget --quiet \
         --output-document=/jdk-8.tar.gz \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --verbose --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# set the environment variables 
ENV JDK_HOME /usr/lib/jvm/jdk1.8.0_101
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_101
ENV PATH $PATH:$JAVA_HOME/bin

    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget --quiet \
         --output-document=/jdk-8.tar.gz \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-i586.tar.gz





RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/*




    tar -xvf /jdk-8.tar.gz -C /usr/lib/jvm


   tar -xvf jdk-8u144-linux-i586.tar.gz -C /opt



## How to Manually Install Java 8 on Ubuntu 16.04
### reflink : https://www.vultr.com/docs/how-to-manually-install-java-8-on-ubuntu-16-04

----------------------------------------------------------------------------------------
### ex
jdk_install.sh

#/bin/sh

tar xvzf jdk-8u92-linux-x64.tar.gz -C /opt

alternatives --install "/usr/bin/java" "java" "/opt/jdk1.8.0_92/bin/java" 1 \
--slave /usr/bin/javac javac /opt/jdk1.8.0_92/bin/javac \
--slave /usr/bin/javaws javaws /opt/jdk1.8.0_92/bin/javaws \
--slave /usr/bin/jar jar /opt/jdk1.8.0_92/bin/jar

alternatives --config java

----------------------------------------------------------------------------------------
## Ubuntu use
update-alternatives --config java


----------------------------------------------------------------------------------------
/usr/lib/jvm/jdk1.8.0_144
/usr/lib/jvm/jdk1.8.0_144/bin
/usr/lib/jvm/jdk1.8.0_144/db/bin
/usr/lib/jvm/jdk1.8.0_144/jre/bin

jdk_install.sh

#/bin/sh

tar xvzf jdk-8u144-linux-i586.tar.gz -C /opt

alternatives --install "/usr/bin/java" "java" "/opt/jdk1.8.0_144/bin/java" 1 \
--slave /usr/bin/javac javac /opt/jdk1.8.0_144/bin/javac \
--slave /usr/bin/javaws javaws /opt/jdk1.8.0_144/bin/javaws \
--slave /usr/bin/jar jar /opt/jdk1.8.0_144/bin/jar

alternatives --config java

----------------------------------------------------------------------------------------

# vi /etc/environment
## Before
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

## After
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk1.8.0_144/bin:/usr/lib/jvm/jdk1.8.0_144/db/bin:/usr/lib/jvm/jdk1.8.0_144/jre/bin"
J2SDKDIR="/usr/lib/jvm/jdk1.8.0_144"
J2REDIR="/usr/lib/jvm/jdk1.8.0_144/jre"
JAVA_HOME="/usr/lib/jvm/jdk1.8.0_144"
DERBY_HOME="/usr/lib/jvm/jdk1.8.0_144/db"

----------------------------------------------------------------------------------------

# update-alternatives

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_144/bin/java 0
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_144/bin/javac 0
sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_144/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_144/bin/javac


# update-alternatives

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_144/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_144/bin/javac 1
sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_144/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_144/bin/javac


Step 5: Setup verification
# update-alternatives --list java
# update-alternatives --list javac



Step 6: Verify the Java version
java -version


find / -name alternativesecho $PATH



python-software-properties \
vim

ENV JAVA_HOME=/opt/jdk/1.8.0_144
wget \
  --no-cookies \
  --no-check-certificate \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  -qO- \
  "http://download.oracle.com/otn-pub/java/jdk/8u144-b14/jdk-8u144-linux-x64.tar.gz" | sudo tar -zx -C /opt/




copy jdk-8u144-linux-i586.tar.gz /root






































