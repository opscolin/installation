#!/usr/bin/env bash
# encoding: utf-8
# Author: colinspace
# Date: 2018-12
# Desc: install taobao tsar command 
# 


## get
cd /tmp
wget -O tsar.zip https://github.com/alibaba/tsar/archive/master.zip --no-check-certificate

## unzip 
echo '==> try to unzip '
unzip tsar.zip

## enter and install
cd tsar-master
echo '==> try to make'
make 
if [ $? -eq 0 ]
then
	echo '==> try to make install'
	make install
else
	echo '==> make failed and exit'
	exit
fi

## delete 
echo '==> delete unusage '
cd /tmp
rm -rf tsar.zip tsar-master
