#!/bin/bash

#Java installation
yum -y install java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64 net-tools vim git 

#User creation
useradd -d /opt/tomcat -s /bin/bash tomcat
echo 'tomcat' | passwd tomcat --stdin

#Tomcat installation
cd /opt/
wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-9/v9.0.8/bin/apache-tomcat-9.0.8.tar.gz
tar -xzvf apache-tomcat-9.0.8.tar.gz && mv apache-tomcat-9.0.8/* tomcat/ && rm -rf apache*
chown -hR tomcat:tomcat /opt/tomcat/

#Tomcat service
cat > /etc/systemd/system/tomcat.service <<EOF
[Unit]
Description=Apache Tomcat 9 Servlet Container
After=syslog.target network.target
 
[Service]
User=tomcat
Group=tomcat
Type=forking
Environment=CATALINA_PID=/opt/tomcat/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

netstat -tulpn
systemctl status tomcat
