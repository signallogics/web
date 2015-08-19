#!/bin/bash

# update sources
git pull

# compile
npm install
gulp --production

# kill process
npm stop --production

# start
npm start --production
