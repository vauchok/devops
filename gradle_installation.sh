#!/bin/bash
#Installation and configuration Gradle-4.4.1

cd /opt/
wget https://services.gradle.org/distributions/gradle-4.4.1-bin.zip 
yum -y install unzip
unzip gradle-4.4.1-bin.zip && rm -rf gradle-4.4.1-bin.zip
sed -i '/PATH=$PATH:$HOME/a \ export PATH=$PATH:/opt/gradle-4.4.1/bin' ~/.bashrc
source ~/.bashrc
