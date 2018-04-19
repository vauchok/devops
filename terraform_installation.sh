 $$#!/bin/bash

yum -y install unzip
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip -d /usr/local/bin/ && rm -rf terraform_0.11.7_linux_amd64.zip
ln -s /usr/local/bin/terraform /usr/bin/terraform
terraform -v
