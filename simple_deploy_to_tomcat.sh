#!/bin/bash

TOMCAT=/opt/apache-tomcat-8.5.23
ARTIFACTS=`echo $TOMCAT/artifacts`
BACKUP=`echo $TOMCAT/backups`
REPOSITORY=`echo $JENKINS_HOME/workspace/rep`

function create_dir {
    ssh tomcat@tomcat << EOF
    if [ ! -d $1 ]; then
        printf 'No $1 directory; creating $1 directory...'
        mkdir -p $1
    else
        printf '$1 directory exists\n'
    fi
EOF
}

create_dir $BACKUP
create_dir $ARTIFACTS

scp $REPOSITORY/$NUM.tar.gz tomcat@tomcat:$ARTIFACTS
ssh tomcat@tomcat "tar -zxvf $ARTIFACTS/$NUM.tar.gz -C $ARTIFACTS && cp $TOMCAT/webapps/hello.war $BACKUP && curl -v --user tomcat:tomcat --upload-file $ARTIFACTS/$NUM.war 'http://tomcat/manager/text/deploy?path=/hello&update=true' && rm -rf $ARTIFACTS"

####_Tests_####
t1=$(curl -L http://tomcat/hello | sed -n '/Hello World AGAIN!/p')
t2=$(curl -LI http://tomcat/hello  | sed -n '/HTTP\/1.1 200/p')
t3=$(ssh tomcat@tomcat "ps -ef | grep tomcat | sed -n '/\/usr\/bin\/java/p'")

if [[ $t1 > 0 && $t2 > 0 && $t3 > 0 ]]; then
    printf 'Fine\n'
else
    printf 'Not Fine\n'
    ssh tomcat@tomcat "curl -v --user tomcat:tomcat --upload-file $BACKUP/hello.war 'http://tomcat/manager/text/deploy?path=/hello&update=true'"
fi
