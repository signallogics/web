# ctfight/web

## Getting Started
### Prerequisites
* Unix-based operating system (OS X or Linux)
* `Docker` should be installed
* `wget` should be installed

### Basic Installation
CTFight/web is installed by running one of the following command.
Paste it to your terminal and follow installation instructions.

```bash
sh -c "$(wget https://github.com/ctfight/web/raw/master/install/remote_install.sh -O -)"
```

Site will run at port 4000  
Admin client at port 4001  
(MongoDB at standart 27017 port)  

##### Basic Installation Contain
* MongoDB inside `mongo_ctfight` container
* NodeJS express-based application inside `node_ctfight` container
* Admin database client (mongo-express) inside `admin_ctfight` container

### Manual Installation
Use this type of installation for development

1. Install [node.js](https://nodejs.org) (`npm` will install automatically)
2. Install `apt-get install git-core`
3. Clone repository `git clone https://github.com/ctfight/web.git` ctfight-web
4. Go to work folder `cd ctfight-web`
5. Run `npm install -g gulp coffee-script nodemon`
6. Run `npm install`
7. _(Optional)_ Configure [mongo-express](https://github.com/andzdroid/mongo-express) if you need admin database client

### Development
Use `gulp` for compiling stylus, yaml and coffeescript (front-end).  
Use `gulp watch` for development. It compile files as soon as they change and it run server at `http://localhost:3000`  
Use `gulp --production` for compiling files for production  
Use `npm start` for start service at `http://localhost:5000` (You must compile files before)

## Using Docker
_`<container>` is one of `mongo_ctfight`, `node_ctfight` and `admin_ctfight`_

Use `docker start` to start your containers
```bash
docker start <container>
```

Similarly use `docker stop`
```bash
docker stop <container>
```

Get terminal of running container
```bash
docker exec -it <container> bash
```

Get list of running process
```bash
docker ps
```

For more information use [Docker documentation](https://docs.docker.com)

# How to

## How to install docker

#### Debian
Add to /etc/apt/source.list:

```bash
deb http://linux.nsu.ru/debian jessie-backports main contrib non-free
deb-src http://linux.nsu.ru/debian jessie-backports main contrib non-free
```

Update cache:

```bash
apt-get update
```

Install:

```bash
apt-get install docker.io
```


#### OS X
_Note: Use [Docker official documentation](https://docs.docker.com/installation/mac/) if you want to install without Homebrew_
* [Homebrew](http://brew.sh) should be installed
* [VirtualBox](http://virtualbox.org) should be installed


Install docker and boot2docker:
```bash
brew install docker boot2docker
```

Create virtual machine:
```bash
boot2docker init
```

Run boot2docker:
```bash
boot2docker up
```

Add boot2docker initialization to your shell config (It is often .bashrc)
```bash
echo 'eval "$(boot2docker shellinit)"' >> ~/.bashrc
```
