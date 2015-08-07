
# open and edit ~/.zshrc file to replace all content with following-
# source ~/dotfiles/zshell/.zshrc

# copy git specific files
cp ~/dotfiles/git/.gitconfig ~/.gitconfig 
cp ~/dotfiles/git/.gitignore ~/.gitignore

# create the .gitconfig on home directory and copy  and format above stuff 
echo "[include] path= ~/dotfiles/git/.gitconfig" > ~/.gitconfig


# copy the terminator config file 
cp ~/dotfiles/terminator/config ~/.config/terminator/config 

# copy the tmux configuration file 
sudo cp ~/dotfiles/tmux/tmux.conf /etc/tmux.conf

# install flashplayer 
# Go to software center
# search for pepper flash player and install it 

# create file called git-diff.sh and paste following content 
#!/bin/bash 
meld "$2" "$5" > /dev/null 2>&1

# save it in /usr/local/bin 
sudo mv git-diff.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/git-diff.sh

# elastic home directory 
# /usr/share/elasticsearch
# elastic search configuration
# /etc/elasticsearch/

# install head plugin 
sudo /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head

## download and install ubuntu docker image
sudo docker run -i -t ubuntu /bin/bash

