#!/bin/bash -e

if [ ! -d "all_in_one" ]; then
	mkdir all_in_one
	wget https://github.com/ctfight/web/raw/master/install/all_in_one/Dockerfile -O all_in_one/Dockerfile
	wget https://github.com/ctfight/web/raw/master/install/all_in_one/config.js -O all_in_one/config.js
	wget https://github.com/ctfight/web/raw/master/install/all_in_one/supervisord.conf -O all_in_one/supervisord.conf
fi

# function generate cookie and session secrets
chars=( {a..z} {A..Z} {0..9} )
function rand_string () {
	local c=$1 ret=
	while((c--)); do
		ret+=${chars[$((RANDOM%${#chars[@]}))]}
	done
	printf '%s\n' "$ret"
}

cookiesecret=$(rand_string 30)
sessionsecret=$(rand_string 30)
printf "Login 'admin'. Type pass: "
read pass

sed -i.bak "s/'secret_pass'/'$pass'/" all_in_one/config.js
sed -i.bak "s/'cookiesecret'/'$cookiesecret'/" all_in_one/config.js
sed -i.bak "s/'sessionsecret'/'$sessionsecret'/" all_in_one/config.js

docker build -t ctfight_web all_in_one

sed -i.bak "s/'$pass'/'secret_pass'/" all_in_one/config.js
sed -i.bak "s/'$cookiesecret'/'cookiesecret'/" all_in_one/config.js
sed -i.bak "s/'$sessionsecret'/'sessionsecret'/" all_in_one/config.js

rm all_in_one/config.js.bak
docker run -d --name ctfight_web -p 4001:8081 -p 4000:5000 ctfight_web
