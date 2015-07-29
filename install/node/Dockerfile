FROM debian:latest
MAINTAINER Samoilov Maxim <nitive@icloud.com>

RUN apt-get update
RUN apt-get install -y \
  git \
  curl \
  build-essential

RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install -y nodejs

RUN git clone https://github.com/ctfight/web.git /ctfight-web
WORKDIR /ctfight-web
RUN npm install -g gulp coffee-script nodemon
RUN npm install
RUN gulp --production

EXPOSE 5000

CMD npm start --production
