#!/bin/bash

# to update change TERRAGRUNT_VERSION
TERRAGRUNT_VERSION="v0.18.6"
TERRAGRUNT_CURRENT_VERSION=`./terragrunt -version | cut -d " " -f 3`

if [ -f "terragrunt" -a $TERRAGRUNT_CURRENT_VERSION == $TERRAGRUNT_VERSION ]; then
    echo "terragrunt is up to date"
else
    rm -rf terragrunt
    wget https://github.com/gruntwork-io/terragrunt/releases/download/$TERRAGRUNT_VERSION/terragrunt_linux_amd64 -O terragrunt
    sudo chmod +x terragrunt
fi
