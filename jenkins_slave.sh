#!/bin/bash

JENKINS_USER_HOME=/home/jenkins

#properties for jenkins
useradd jenkins
echo 'jenkins' | passwd jenkins --stdin
mkdir -p /opt/jenkins/jenkins-slave
chown -R jenkins:jenkins /opt/jenkins/jenkins-slave

#java installation
yum -y install vim git unzip java-1.8.0-openjdk-devel
sed -i '/# User specific/a \export JAVA_HOME=/opt/jdk1.8.0_161' $JENKINS_USER_HOME/.bashrc
sed -i '/export JAVA_HOME/a \export PATH=$JAVA_HOME/bin:$PATH' $JENKINS_USER_HOME/.bashrc
source $JENKINS_USER_HOME/.bashrc

#android-sdk installation
mkdir /opt/android-sdk-linux
cd /opt/android-sdk-linux && wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
&& unzip sdk-tools-linux-3859397.zip && rm -rf sdk-tools-linux-3859397.zip
chown -R jenkins:jenkins /opt/android-sdk-linux
sed -i '/PATH=$JAVA_HOME/a \export ANDROID_HOME=/opt/android-sdk-linux' $JENKINS_USER_HOME/.bashrc
sed -i '/export ANDROID_HOME/a \export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH' $JENKINS_USER_HOME/.bashrc
source $JENKINS_USER_HOME/.bashrc

#node.js and react-native installation
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
yum -y groupinstall 'Development Tools'
npm install -g react-native-cli

#install dependency for 32-bit
yum install -y glibc.i686 glibc-devel.i686 libstdc++.i686 zlib-devel.i686 \
ncurses-devel.i686 libX11-devel.i686 libXrender.i686 libXrandr.i686
