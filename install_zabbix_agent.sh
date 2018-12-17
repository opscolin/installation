#!/usr/bin/env bash
#encoding: utf-8
#Author: Colin
#Date:
#Desc: install zabbix 3.2 ; server and agent 
#

rpmaddr='http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm'

## install or update epel-release
yum install epel-release -y

## install zabbix rpm
rpm -ivh ${rpmaddr}

## install zabbix-server-mysql zabbix-web-mysql
yum install zabbix-agent -y


## get host ipaddress
hostip=$(/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"|egrep '^10')

## config agent
cat > /etc/zabbix/zabbix_agent.conf <<EOF
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=0
Server=10.31.148.146
ServerActive=10.31.148.146
Hostname=i${hostip}
Include=/etc/zabbix/zabbix_agentd.d/*.conf
EOF

## enable and start agent
systemctl enable zabbix-agent
systemctl start zabbix-agent

tail -20 /var/log/zabbix/zabbix_agentd.log
