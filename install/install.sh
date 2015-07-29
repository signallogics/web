#!/bin/bash -e

chars=( {a..z} {A..Z} {0..9} )

function rand_string () {
	local c=$1 ret=
	while((c--)); do
		ret+=${chars[$((RANDOM%${#chars[@]}))]}
	done
	printf '%s\n' "$ret"
}

while true; do
	read -p "Would you like to install mongo? (y/n) " yn
	case $yn in
		[Yy]* ) yn_mongo='y'; break;;
		[Nn]* ) yn_mongo='n'; break;;
	esac
done

while true; do
	read -p "Would you like to install node? (y/n) " yn
	case $yn in
		[Yy]* ) yn_node='y'; break;;
		[Nn]* ) yn_node='n'; break;;
	esac
done

while true; do
	read -p "Would you like to install mongo-express? (y/n) " yn
	case $yn in
		[Yy]* ) yn_mongo_express='y'; printf "Login 'admin'. Type pass: "; read pass; break;;
		[Nn]* ) yn_mongo_express='n'; break;;
	esac
done

while true; do
	read -p "Would you like to start containers after installation? (y/n) " yn
	case $yn in
		[Yy]* ) yn_start='y'; break;;
		[Nn]* ) yn_start='n'; break;;
	esac
done


if [[ "$yn_mongo" = "y" ]]; then
	docker build -t ctfight_mongo mongo
	docker run -d --name mongo_ctfight ctfight_mongo mongod --smallfiles
	if [[ "$yn_start" = "n" ]]; then
		docker stop mongo_ctfight
	fi
fi

if [[ "$yn_node" = "y" ]]; then
	docker build -t ctfight_node node
	docker run -d --name node_ctfight --link mongo_ctfight:mongo -p 4000:5000 ctfight_node
	if [[ "$yn_start" = "n" ]]; then
		docker stop node_ctfight
	fi
fi

if [[ "$yn_mongo_express" = "y" ]]; then
	cookiesecret=$(rand_string 30)
	sessionsecret=$(rand_string 30)

	sed -i.bak "s/'secret_pass'/'$pass'/" admin/config.js
	sed -i.bak "s/'cookiesecret'/'$cookiesecret'/" admin/config.js
	sed -i.bak "s/'sessionsecret'/'$sessionsecret'/" admin/config.js

	docker build -t ctfight_admin admin

	sed -i.bak "s/'$pass'/'secret_pass'/" admin/config.js
	sed -i.bak "s/'$cookiesecret'/'cookiesecret'/" admin/config.js
	sed -i.bak "s/'$sessionsecret'/'sessionsecret'/" admin/config.js

	rm admin/config.js.bak
	docker run -d --name admin_ctfight   --link mongo_ctfight:mongo -p 4001:8081 ctfight_admin
	if [[ "$yn_start" = "n" ]]; then
		docker stop admin_ctfight
	fi
fi

clear
echo '\nNew docker images:'
docker images | grep ctfight_
