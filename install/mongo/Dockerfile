FROM debian:latest
MAINTAINER Samoilov Maxim <nitive@icloud.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

EXPOSE 27017
# EXPOSE 28017

VOLUME /data/db

CMD mongod
