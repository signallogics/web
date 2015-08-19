#!/bin/bash

# update sources
git pull --rebase

# compile
npm install
gulp --production

# TODO: need kill all node process
# TODO: need kill all mongod process

# start mongod
(mongod > mongod.log &> error_mongod.log &)

# start site
(npm start --production > start.log &> error.log &)
