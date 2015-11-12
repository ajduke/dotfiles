Reference - http://sourabhbajaj.com/mac-setup/


* Install Home brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

* install git
brew install git

* install zsh
brew install zsh zsh-completions

* install oh my zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

* change shell
chsh -s /bin/zsh

* copy .zshrc to home directory and reload zshell config

* make path to .gitignore
echo "[include] path= ~/dotfiles/git/.gitconfig" > ~/.gitconfig
cp ~/dotfiles/git/.gitignore ~/.gitignore

* install fortune and cowsay
gem install fortune cowsay

* install npm global npm module
sudo npm install coffee-script pm2 nodemon

* install meteor
curl https://install.meteor.com/ | sh

* install mongodb
brew update
brew install mongodb

* install node
brew update
brew install node

* install tmux
brew install tmux
