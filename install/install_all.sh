#!/bin/bash -e

# function generate random strings (cookie and session secrets)
chars=( {a..z} {A..Z} {0..9} )
function rand_string () {
	local c=$1 ret=
	while((c--)); do
		ret+=${chars[$((RANDOM%${#chars[@]}))]}
	done
	printf '%s\n' "$ret"
}

# generate secret fields for config.js
cookiesecret=$(rand_string 30)
sessionsecret=$(rand_string 30)

# read password for admin client
printf "Login for admin client is 'admin'. Type password: "
read pass

# replace defaults password and secrets
sed -i.bak "s/'secret_pass'/'$pass'/" all_in_one/config.js
sed -i.bak "s/'cookiesecret'/'$cookiesecret'/" all_in_one/config.js
sed -i.bak "s/'sessionsecret'/'$sessionsecret'/" all_in_one/config.js

# build image
docker build -t ctfight_web all_in_one

# return defaults password and secrets
sed -i.bak "s/'$pass'/'secret_pass'/" all_in_one/config.js
sed -i.bak "s/'$cookiesecret'/'cookiesecret'/" all_in_one/config.js
sed -i.bak "s/'$sessionsecret'/'sessionsecret'/" all_in_one/config.js

# remove extra file (creted with sed)
rm all_in_one/config.js.bak

# run container
docker run -d --name ctfight_web -p 4001:8081 -p 4000:5000 ctfight_web
