#!/bin/bash
apt update
apt -y install apache2
echo "Hello world from $(hostname) $(hostname -i)"> /var/www/html/index.html