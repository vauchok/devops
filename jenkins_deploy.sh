#!/bin/bash

#java instalation
yum -y install java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64 git vim
sed -i '/PATH=$PATH:$HOME/a \ export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.el7_4.x86_64/jre' ~/.bash_profile
sed -i '/export JAVA_HOME/a \ export PATH=$JAVA_HOME/bin:$PATH' ~/.bash_profile
source ~/.bash_profile

#nginx instalation and configuration
yum -y install nginx
sed -i '47a\ \tproxy_pass http://127.0.0.1:8080;\n\tproxy_redirect off;\n\tproxy_set_header Host $host;\n\tproxy_set_header X-Real-IP $remote_addr;\n\tproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n\tproxy_set_header X-Forwarded-Proto $scheme;' /etc/nginx/nginx.conf 
systemctl start nginx
systemctl enable nginx

#jenkins instalation
useradd jenkins
echo 'jenkins' | passwd jenkins --stdin

cd /opt/
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

cat > /etc/systemd/system/jenkins.service <<EOF
[Unit]
Description=Jenkins Daemon

[Service]
ExecStart=/usr/bin/java -jar /opt/jenkins.war
User=jenkins

[Install]
WantedBy=multi-user.target
EOF

systemctl enable jenkins
systemctl start jenkins
