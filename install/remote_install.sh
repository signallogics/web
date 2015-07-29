mkdir -p ctfight_install ctfight_install/mongo ctfight_install/node ctfight_install/admin
cd ctfight_install
wget https://raw.githubusercontent.com/ctfight/web/master/install/install.sh -O install.sh
wget https://raw.githubusercontent.com/ctfight/web/master/install/mongo/Dockerfile -O mongo/Dockerfile
wget https://raw.githubusercontent.com/ctfight/web/master/install/node/Dockerfile -O node/Dockerfile
wget https://raw.githubusercontent.com/ctfight/web/master/install/admin/Dockerfile -O admin/Dockerfile
wget https://raw.githubusercontent.com/ctfight/web/master/install/admin/config.js -O admin/config.js

chmod +x install.sh
./install.sh
cd ..
rm -r ctfight_install
