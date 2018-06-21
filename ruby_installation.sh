#!/bin/bash

yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel \
   libyaml-devel libffi-devel openssl-devel make \
   bzip2 autoconf automake libtool bison iconv-devel sqlite-devel

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L get.rvm.io | bash -s stable

source /etc/profile.d/rvm.sh
rvm reload

rvm requirements run
rvm install 2.4.1
ruby --version
rvm install 2.5.2
ruby --version
rvm list
rvm use 2.4.1 --default
ruby --version
