FROM debian:latest
MAINTAINER Samoilov Maxim <nitive@icloud.com>

# install mongodb
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

VOLUME /data/db

# install nodejs
RUN apt-get update
RUN apt-get install -y \
  git \
  curl \
  supervisor \
  build-essential

RUN mkdir -p /var/log/supervisor
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install -y nodejs

# ctfight-web and admin client
RUN git clone https://github.com/ctfight/web.git /ctfight-web
WORKDIR /ctfight-web
RUN npm install -g gulp coffee-script nodemon
RUN npm install
RUN gulp --production
ADD ./config.js node_modules/mongo-express/config.js
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5000 8081

# run all
CMD ["/usr/bin/supervisord"]
