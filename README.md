# ctfight/web

[![Join the chat at https://gitter.im/ctfight/web](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ctfight/web?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

![](lib/static/images/header.png)

## Getting Started
### Prerequisites
* Unix-based operating system (OS X or Linux)
* `Docker` must be installed
* `wget` must be installed

### Installation to one docker container
1. Clone repository `git clone https://github.com/ctfight/web.git ctfight-web`
2. Go to install folder `cd ctfight-web/install`
3. Give permission to `install_all.sh` script `chmod +x install_all.sh`
4. Run script `./install_all.sh`
5. Follow installation instructions

Site will run at port 4000  
Admin client at port 4001  

### Basic Installation
To get your CTFight/web you'll need to run the following command.
Paste it into your terminal and follow installation instructions.

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

### Update
1. Get terminal of node\_ctfight `docker exec -it node_ctfight bash`
2. Download latest version of sources `git pull --rebase`
3. Update node modules `npm install`
4. Compile assets `gulp --production`
5. Press `^D` to exit

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
11. Copy config file: `cp node_modules/mongo-express/config.default.js node_modules/mongo-express/config.js`
12. Configure: `nano node_modules/mongo-express/config.js` _(Default login is `admin`, password is `pass`)_
13. Run `npm start`
14. Look your site on `http://localhost:5000` (default port)

### Development
Use `gulp` to compile stylus, yaml and coffeescript (front-end).  
Use `gulp watch` to develop. It compiles files as soon as they change and it runs server at `http://localhost:3000`  
Use `gulp --production` to compile files for production  
Use `npm start` to start service at `http://localhost:5000` (You must compile files in first)
Use `npm run admin` to start admin client at `http://localhost:8081`

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

Get terminal of the running container
```bash
docker exec -it <container> bash
```

Get list of running processes
```bash
docker ps
```

For more information use [Docker documentation](https://docs.docker.com)

# How to

## How to install docker

#### Debian

```bash
curl -sSL https://get.docker.com/ | sh
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

Add boot2docker initialization to your shell config (Usually it's .bashrc)
```bash
echo 'eval "$(boot2docker shellinit)"' >> ~/.bashrc
```
