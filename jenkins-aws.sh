#!/bin/bash

sudo yum update -y
sudo yum install -y git
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk-devel

echo "installing tomcat"
sudo yum install -y tomcat8 tomcat8-webapps tomcat8-admin-webapps tomcat8-docs-webapp
sudo sed "$d" /usr/share/tomcat8/conf/tomcat-users.xml
echo "  <user username=\"tomcat\" password=\"tomcat\" roles=\"manager-script\" />" >> /usr/share/tomcat8/conf/tomcat-users.xml
echo "</tomcat-users>" >> /usr/share/tomcat8/conf/tomcat-users.xml
sudo chmod 777 -R /usr/share/tomcat8
sudo sed -i 's/<Connector port="8080"/<Connector port="80"/' /usr/share/tomcat8/conf/server.xml
sudo service tomcat8 start
export CATALINA_HOME=/usr/share/tomcat8

echo "installing jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum install -y jenkins
sudo service jenkins start

echo "installing docker"
sudo yum install -y docker
sudo groupadd docker
sudo usermod -aG docker jenkins
sudo service jenkins restart