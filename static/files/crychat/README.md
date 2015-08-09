# CryChat ( == Crypto Chat)

Service requeried: PHP 5(+GD2) + Apache.

    # apt-get install apache2 php5 php5-gd
    
Checker requeried: curl.

    # apt-get install curl

Files:

	# mkdir /var/www/crychat
	# cp -R www/* /var/www/html/crychat/*
	# chmod 777 -R /var/www/html/crychat/

# directory with session files:

	# chown www-data:www-data /var/lib/php5

# Checker

checker-crychat.sh

# url
    
    # http://host/index.php

# Checker input params

	COMMAND=$1
	HOST=$2
	ID=$3
	FLAG=$4

# Example checker call 

	#!/bin/bash

	echo "TEST PUT"
	./checker-crychat.sh put 172.17.0.65 someid3 4FE93926-55E6-47E7-9089-9BDED570B631
	echo "TEST GET"
	./checker-crychat.sh get 172.17.0.65 someid3 4FE93926-55E6-47E7-9089-9BDED570B631
	echo "TEST CHECK"
	./checker-crychat.sh check 172.17.0.65
