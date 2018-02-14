#!/bin/bash
#Installation and configuration Maven-3.5.2

cd /tmp/
wget http://www-us.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
tar xzf apache-maven-3.5.2-bin.tar.gz && rm -rf apache-maven-3.5.2-bin.tar.gz 
sed -i '/PATH=$PATH:$HOME/a \ export M2_HOME=/tmp/apache-maven-3.5.2' ~/.bashrc 
sed -i '/export M2_HOME/a \ export PATH=$M2_HOME/bin:$PATH' ~/.bashrc
source ~/.bashrc
mvn -v
