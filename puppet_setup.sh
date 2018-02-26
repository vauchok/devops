#!/bin/bash

#install to centos7
rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y install puppetserver git vim 

sed -i 's~JAVA_ARGS="-Xms2g -Xmx2g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"~JAVA_ARGS="-Xms512m -Xmx512m -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"~g' /etc/sysconfig/puppetserver

systemctl enable puppetserver
systemctl start puppetserver

sed -i '/codedir/a \[agent]' /etc/puppetlabs/puppet/puppet.conf
sed -i '/agent/a \server = master.puppet.vm' /etc/puppetlabs/puppet/puppet.conf

#install path's variable to gem
sed -i '/# User specific/a \PATH=$PATH:/opt/puppetlabs/puppet/bin:$HOME/bin' ~/.bashrc
source ~/.bashrc

gem install r10k

#to configure r10k
mkdir /etc/puppetlabs/r10k
cat > /etc/puppetlabs/r10k/r10k.yaml <<EOF
---
:cachedir: '/var/cache/r10k'

:sources:
        :my-org:
                remote: 'https://github.com/some_rep.git'
                basedir: '/etc/puppetlabs/code/environments'
EOF
