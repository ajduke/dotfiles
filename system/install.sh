
# basic install
echo "############## basic Install"
sudo apt-get install curl
sudo apt-get install tree


# Terminator
echo "############## Installing Terminator"
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator


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
sudo apt-get install python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs

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

echo "############## Installing global npm packages"
sudo npm install bower -g
sudo npm install coffee-script -g
sudo npm install nodemon -g
sudo npm install meteorite -g 

echo "############## Install Sass"
sudo gem install sass

echo "############## Install Zshell"
sudo apt-get install zsh  
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
chsh -s /bin/zsh

echo "############## Install Extra Goodies"
sudo apt-get install fortune cowsay 

echo "############## SOme directories"
cd ~
mkdir workspace
mkdir apps

echo "########### Genrating SSH keys now"
ssh-keygen -t rsa -C "ajduke@about.me" 

echo "########### Here goes your ssh key "
cat ~/.ssh/id_rsa.pub 
echo "########### Ssh keys ends here"

echo "########### chwowning directories"
sudo chown -R siddhi ~/.npm
sudo chown -R siddhi ~/.meteor

echo "############## Congratualations installation done!!!"
echo "Install following thing by your own"
echo "Webstorm IDE"
echo "Brackets Editor"