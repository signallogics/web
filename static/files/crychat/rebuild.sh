#!/bin/bash

SERVICENAME=crychat

# kill docker service
if [[ $(docker ps -a | grep "ctfight:$SERVICENAME" | wc -l) > 0 ]]; then
        echo -n "Kill container(s) 'ctfight:$SERVICENAME' ... "
        docker rm -f $(docker ps -a | grep "ctfight:$SERVICENAME" | sed -s 's/.*\([0-9a-z]\{12,12\}\) .*/\1/') > /dev/null
        if [[ $(docker ps -a | grep "ctfight:$SERVICENAME" | wc -l) > 0 ]]; then
                echo "[FAIL]"
                echo "Could not kill all ctfight:$SERVICENAME containers"
                exit 102
        fi
        echo "[OK]"
fi

# remove old image docker
if [[ $(docker images | grep "$SERVICENAME" | wc -l) > 0 ]]; then
        OLD_SERVICE_IMAGE_ID=$(docker images | grep $SERVICENAME | sed -s 's/.* \([0-9a-z]\{12,12\}\) .*/\1/')
        # TODO: kill docker if running
        echo -n "Remove old service image 'ctfight:$SERVICENAME' with id=$OLD_SERVICE_IMAGE_ID ... "
        docker rmi -f $OLD_SERVICE_IMAGE_ID > /dev/null
        if [[ $(docker images | grep $SERVICENAME | wc -l) > 0 ]]; then
                echo "[FAIL]"
                echo "Could not remove all ctfight:crychat images"
                exit 103
        fi
        echo "[OK]"
fi

# build image
docker build --rm=true -t ctfight:$SERVICENAME ./

TEAMNAME=test
# run services
echo -n "Run service '$TEAMNAME-$SERVICENAME' ... "
docker run -t --name=$TEAMNAME-$SERVICENAME ctfight:$SERVICENAME > /dev/null &
sleep 3s

if [[ $(docker ps | grep "$TEAMNAME-$SERVICENAME" | wc -l) != 1 ]]; then
	echo "[FAIL]"
	echo "Could not run new container"
        exit 105
fi
echo "[OK]"
TEAMIP=$(docker exec $TEAMNAME-$SERVICENAME ip addr show eth0 | grep "inet " | sed -s 's/.*inet \([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*/\1/')
echo "Containner-IP: $TEAMIP"
ROOTPSWD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-7};echo;)
echo "root:$ROOTPSWD" | docker exec -i $TEAMNAME-$SERVICENAME chpasswd
echo "Root-password: $ROOTPSWD"
