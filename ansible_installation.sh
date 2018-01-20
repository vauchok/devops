#!/bin/bash

#Ansible installation
yum -y install python-paramiko python2-pip make git gcc python-devel libffi-devel openssl-devel epel-release python-sphinx
pip install jinja2 pyyaml

git clone https://github.com/ansible/ansible.git
cd ./ansible
make
make install
