#!/usr/bin/env bash
#-*- coding: utf-8 -*-
#Author: Colin
#Date: 2017-12-07
#Desc: 自动化安装redis服务
#

if [ $# -eq 1 ]
then
	version="$1"
else
	version="stable"
fi

echo "You will try to install [${version}] ..."
tarpackage="redis-${version}.tar.gz"
untarpackage="redis-${version}"

if [ -f ${tarpackage} ]
then
	echo "find downloaded package and use it to install ..."
else
	echo "download first and then install ..."
	downaddr="http://download.redis.io/releases/${tarpackage}"
	wget ${downaddr}
fi


echo "untar package ..."
tar -zxvf ${tarpackage}
cd ${untarpackage}
echo "try to make ..."
make
cd src
echo "try to install under /usr/local/redis ..."
make install PREFIX=/usr/local/redis

echo "try to add redis into environment ..."
flag=$(cat /root/.bashrc|grep -i redis_home|wc -l)
if [ $flag -eq 0 ]
then
	sed -i '$aexport REDIS_HOME=/usr/local/redis' /root/.bashrc
	sed -i '$aexport PATH=$PATH:$REDIS_HOME/bin' /root/.bashrc
else
	echo "Had exist variable 'REDIS_HOME', please check and add by hand ..."
fi

echo "=================================================="
echo "After installation, you can create your own config file and start redis service"
echo "vim /etc/redis.conf"
echo "here make sure you add 'daemonize yes' into /etc/redis.conf"
echo "and let it run in background"
echo "/usr/local/redis/bin/redis-server /etc/redis.conf"
echo "=================================================="
