#!/bin/bash
#Nexus server installation

adduser nexus
echo 'nexus' | passwd nexus --stdin

#####_JAVA_instalation_#####
yum -y install java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64
sed -i '/PATH=$PATH:$HOME/a \ export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.el7_4.x86_64/jre' ~/.bashrc
sed -i '/export JAVA_HOME/a \ export PATH=$JAVA_HOME/bin:$PATH' ~/.bashrc
source ~/.bashrc

#####_NGINX_instalation_and_configuration_#####
yum -y install nginx
sed -i '47a\ \tproxy_pass http://127.0.0.1:8081;\n\tproxy_redirect off;\n\tproxy_set_header Host $host;\n\tproxy_set_header X-Real-IP $remote_addr;\n\tproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n\tproxy_set_header X-Forwarded-Proto $scheme;' /etc/nginx/nginx.conf
sed -i '/types_hash_max_size/a \    client_max_body_size 10M;' /etc/nginx/nginx.conf
systemctl start nginx
systemctl enable nginx

#####_Nexus_installation_#####
wget http://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar xvf latest-unix.tar.gz -C /opt && rm -rf latest-unix.tar.gz
ln -s /opt/nexus-3.8.0-02/ /opt/nexus
chown -R nexus:nexus /opt/nexus
chown -R nexus:nexus /opt/sonatype-work
sed -i 's~#run_as_user=""~run_as_user="nexus"~g' /opt/nexus/bin/nexus.rc
ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
chkconfig --add nexus 
chkconfig --levels 345 nexus on
systemctl enable nexus
systemctl start nexus

