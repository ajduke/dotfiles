
# basic install
echo "############## basic Install"
sudo apt-get install curl
sudo apt-get install tree
sudo apt-get install xclip

echo '############### Installing Chrome '
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# Terminator
echo "############## Installing Terminator"
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator

# install tmux
echo "############## Installing Tmux"
sudo add-apt-repository ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install tmux

#install git
echo "############## Installing Git"
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

#SmartGit
echo "############## Installing Smart Git"
sudo add-apt-repository ppa:eugenesan/ppa
sudo apt-get update
sudo apt-get install smartgit

#install sublime 2
echo "############## Installing Sublime Text 2 "
sudo apt-get update
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text

echo "## Installing meld diff tool"
sudo apt-get update && sudo apt-get install meld

#install nodejs
echo "############## Installing NodeJS and NPM"
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install -y nodejs

# Optional install for Nodejs- Using NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# install meteor
echo "############## Installing Meteor"
curl https://install.meteor.com/ | sh

#install java
echo "############## Installing Oracle Java 8"
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

#install mongodb
echo "############## Installing MongoDB 2.6"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-org

#robomongo
echo "############## Installing RoboMongo"
wget http://robomongo.org/files/linux/robomongo-0.8.4-x86_64.deb
sudo dpkg -i robomongo*.deb

# install Redis
echo "############## Installing Redis"
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:rwky/redis
sudo apt-get update
sudo apt-get install -y redis-server

#Ruby
echo "############## Installing Ruby"
sudo apt-get install ruby

#openoffice
echo "############## removing libreoffice"
sudo apt-get remove --purge libreoffice*
sudo apt-get clean
sudo apt-get autoremove

# install zsh
echo "####### install zsh ############"
sudo apt-get install zsh
curl -L http://install.ohmyz.sh | sh
chsh -s `which zsh`

echo "############## Installing global npm packages"
sudo npm install nodemon -g
sudo npm install diff-so-fancy -g
sudo npm install yarn -g

echo "############## Install Sass"
sudo gem install sass

echo "############## Install Extra Goodies"
sudo apt-get install fortune cowsay

echo "############ Installing elastic search, look for lastest version"
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.1.deb
dpkg -i elasticsearch-0.90.7.deb

sudo apt update
sudo apt install python3-dev python3-pip
sudo -H pip3 install thefuck

echo "########## Installing docker #########"
curl -sSL https://get.docker.com/ubuntu/ | sudo sh

echo "############## Congratualations installation done!!!"
echo "Install following thing by your own"
echo "Webstorm IDE"
echo "Brackets Editor"
