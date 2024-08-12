#!/bin/bash

apt update -y
apt list --upgradable
apt install redis-tools -y
apt install nginx -y
systemctl enable nginx
systemctl start nginx
exit