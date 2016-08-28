# Reference - http://sourabhbajaj.com/mac-setup/

# Install Home brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install git
brew install git

# install zsh
brew install zsh zsh-completions

# install oh my zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# change shell
chsh -s /bin/zsh

# copy .zshrc to home directory and reload zshell config
git clone  --recursive -j8 https://github.com/ajduke/dotfiles.git ~/dotfiles
echo 'source ~/dotfiles/zshell/zshrc' > ~/.zshrc
source ~/.zshrc

# put it optional
# git submodule update --int --recursive

# make path to .gitignore
echo "[include] path= ~/dotfiles/git/gitconfig" > ~/.gitconfig
cp ~/dotfiles/git/gitignore ~/.gitignore

# install fortune and cowsay
brew install fortune cowsay

# install npm global npm module
sudo npm i -g coffee-script pm2 nodemon n
# alm emoj eslint express-generator foundation-cli git-stats

# install meteor
curl https://install.meteor.com/ | sh

# install mongodb
brew update; brew install mongodb

# install node
brew update;brew install node

#install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.6/install.sh | bash

# install stable lts node version
nvm install lts
nvm alias latest v6.4.0

# install only npm
curl -L https://www.npmjs.com/install.sh | sh

# install tmux
brew install tmux

# install java
brew update; brew install java

# install elastic search
brew update;brew install elasticsearch


# some extra goodies for git
brew install git-extras git-flow

# to correct last entered command
brew install thefuck wifi-password jo tree

#### installs with Cask #####
brew cask install atom
brew cask install google-chrome
brew cask install qlimagesize
brew cask install betterzipql
brew cask install quicklook-csv
brew cask install quicklook-json
brew cask install qlmarkdown
