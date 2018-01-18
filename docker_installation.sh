#!/bin/bash
#Installation and configuration Docker and Docker-compose

#docker installation
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
yum -y install docker-ce
usermod -aG docker vagrant

systemctl enable docker
systemctl start docker

#docker-compose installation
yum -y install python-pip
pip install docker-compose
