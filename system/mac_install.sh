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
git clone https://github.com/ajduke/dotfiles.git ~/dotfiles
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
brew update; brew install python
python -V

# install mongodb
brew update; brew install mongodb
mongod -v
mongo -v

# install redis
brew update; brew install redis
redis-cli -v

#install nvm => use the latest from its official the github repo
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.6/install.sh | bash

# install stable lts node version
nvm install lts/*
nvm alias latest lts/*

# Telsconsole to share terminal
curl https://www.teleconsole.com/get.sh | sh

# install tmux
brew install tmux

brew cask install java
# install elastic search
brew update;brew install elasticsearch

# some extra goodies for git
brew install git-extras git-flow

# to correct last entered command
brew install thefuck wifi-password jo tree httpie gcc diff-so-fancy

## lazygit CLI UI 
brew tap jesseduffield/lazygit
brew install lazygit 
brew install blueutil # for bluetooth on/off from CLI

# fx- cli json view for
brew install fx
brew install exa
brew install tldr
brew install tldr
brew install starship

#### installs with Cask #####
brew cask install
  visual-studio-code \
   atom \
   google-chrome \
    iterm2 \
     docker \
       slack \
         spotify\
  qlimagesize \
  betterzipql \
  quicklook-csv \
  quicklook-json\
  qlmarkdown


brew tap homebrew/services

## take Dock to left and run this on left to minimize
# defaults write com.apple.dock autohide-time-modifier -float .5
# killall Dock

Install following applications 