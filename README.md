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
sudo sh -c "$(wget https://github.com/ctfight/web/raw/master/install/remote_install.sh -O -)"
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
1.1 Or install from repository: `sudo apt-get install nodejs nodejs-legacy npm`
2. Install mongodb: `sudo apt-get install mongodb`
3. Start mongodb: `sudo /etc/init.d/mongodb start`
4. Install git: `sudo apt-get install git-core`
5. Clone repository `git clone https://github.com/ctfight/web.git ctfight-web`
6. Go to work folder `cd ctfight-web`
7. Run `npm install -g gulp coffee-script nodemon`
8. Run `npm install`
9. _(Optional)_ Configure [mongo-express](https://github.com/andzdroid/mongo-express) if you need admin database client
10. Run `gulp --production`
11. Copy config file: `cp node_modules/mongo-express/config.default.js node_mod$
12. Configure: `nano node_modules/mongo-express/config.js`
13. Run `npm start`
14. Look your site on `https://<ip>:5000` (default port)

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
