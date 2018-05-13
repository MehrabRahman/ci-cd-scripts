#!/bin/bash

sudo yum update -y
sudo yum install -y git
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk-devel

echo "installing tomcat"
sudo yum install -y tomcat8 tomcat8-webapps tomcat8-admin-webapps
sudo sed -i 's/<\/tomcat-users>/  <user username=\"tomcat\" password=\"tomcat\" roles=\"manager-gui\" \/>\n<\/tomcat-users>/g' /usr/share/tomcat8/conf/tomcat-users.xml
sudo sed -i 's/<Connector port=\"8080\"/<Connector port=\"8888\"/' /usr/share/tomcat8/conf/server.xml
sudo service tomcat8 start
export CATALINA_HOME=/usr/share/tomcat8

echo "installing jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum install -y jenkins
sudo service jenkins start

echo "installing docker"
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker jenkins
sudo service jenkins restart
