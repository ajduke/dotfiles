
echo "[include] path= ~/dotfiles/git/gitconfig" > ~/.gitconfig
echo "source ~/dotfiles/zshell/zshrc" > ~/.zshrc
cp ~/dotfiles/node/npmrc ~/.npmrc

# copy the terminator config file
# cp ~/dotfiles/terminator/config ~/.config/terminator/config

# copy the tmux configuration file
# sudo cp ~/dotfiles/tmux/tmux.conf /etc/tmux.conf

# elastic home directory
# /usr/share/elasticsearch
# elastic search configuration
# /etc/elasticsearch/

# install head plugin
# sudo /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

## download and install ubuntu docker image
# sudo docker run -i -t ubuntu /bin/bash


echo "############## create working directories directories"
mkdir ~/workspace ~/app

chsh -s `which zsh`

echo "########### Here goes your ssh key "
cat ~/.ssh/id_rsa.pub | pbcopy
echo "########### Ssh keys ends here"

echo "########### chwowning directories"
sudo chown -R siddhi ~/.npm
sudo chown -R siddhi ~/.meteor


echo "########### Genrating SSH keys now"

# for github
ssh-keygen -t rsa -C "ajduke@about.me"

# for bitbucket
cd ~/.ssh
ssh-keygen -t rsa -C "myemail"

~/.ssh/id_rsa_bitbucket.pub
~/.ssh/id_rsa_bitbucket

ssh-add -D
ssh-add ~/.ssh/id_rsa_bitbucket.pub
ssh-add ~/.ssh/id_rsa_bitbucket

touch config
atom config


```
Host bitbucket.org
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_rsa_bitbucket.pub

Host bitbucket.org
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_rsa_bitbucket
```


# install global npm packages 


npm install -g emma-cli chalk-animation chalk-cli create-react-app ipt 
