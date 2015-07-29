FROM debian:latest
MAINTAINER Samoilov Maxim <nitive@icloud.com>

RUN apt-get update
RUN apt-get install -y \
  git \
  curl \
  make
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install -y nodejs

WORKDIR /mongo-express
RUN npm install -g nodemon
RUN npm install mongo-express

ADD ./config.js node_modules/mongo-express/config.js

EXPOSE 8081

CMD nodemon node_modules/mongo-express/app.js
