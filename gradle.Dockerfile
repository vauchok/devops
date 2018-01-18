FROM sbeliakou/centos:7.3
MAINTAINER Ihar Vauchok (ihar_vauchok@epam.com)

#Installing dependencies
RUN yum -y install yum-plugin-ovl
RUN yum -y install git wget unzip

#Gradle-4.4.1 installation
RUN cd opt/ && wget https://services.gradle.org/distributions/gradle-4.4.1-bin.zip && unzip gradle-4.4.1-bin.zip && rm -rf gradle-4.4.1-bin.zip
ENV PATH=$PATH:/opt/gradle-4.4.1/bin

#Java-1.8.0 installation
RUN cd opt/ && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz" && tar xzf jdk-8u161-linux-x64.tar.gz && rm -rf jdk-8u161-linux-x64.tar.gz
ENV JAVA_HOME /opt/jdk1.8.0_161
ENV PATH $JAVA_HOME/bin:$PATH

#Building app
RUN git clone https://github.com/vauchok/test_app_src.git
RUN cd test_app_src/ && gradle clean hello


