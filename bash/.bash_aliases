## Colorize the ls output ##
alias ls='ls --color=auto'

## Use a long listing format ##
alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias grep='grep --color=auto'

alias md='mkdir'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias apt-get="sudo apt-get"

alias e='vi'
alias egrep='grep -E'
alias fgrep='grep -F'
alias ls='ls -FG'
alias m='less'
alias md='mkdir'
alias p='pstree -p'
alias sl='ls'
alias tmp='cd /tmp'
alias l='ls -la'
alias dh='df -h'

alias startmongo='sudo mongod -f /etc/mongodb.conf --fork'
alias stopmongo='sudo mongod -f /etc/mongodb.conf --shutdown'
alias by='bunyan -o short'
alias slw='source config/env.sh;meteor'

# git
alias gci=git commit -m
alias gcia=git commit -am

alias gol="git log --date=relative --pretty=format:'%Cred%h %Cblue%ar %Creset%s %Cred%an'"

alias gls="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)[%an]%Creset' --abbrev-commit --date=relative"

alias gld="git log --pretty=format:'%C(red)%h %Cgreen%ad%C(yellow)%d %Creset%s%C(bold blue) [%cn]%Creset' --decorate --date=short"

alias gll="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)[%an]%Creset' --decorate --numstat"
alias gstash="git stash"
alias gstl="git stash list"

# some tmux love
alias tma='tmux a -t'
alias tmn='tmux new -s'
alias tmxx='tmux kill-session -t'
alias tml='tmux ls'
alias tm='tmux attach -t flow || tmux new -s flow'

alias clipb= 'xclip -sel clip'
alias shruggie="printf \"¯\_(ツ)_/¯\" | pbcopy && echo \"¯\_(ツ)_/¯ copied to clipboard\""

# app shortcuts
alias serve-me="harp server -p 8000"
alias es=elasticsearch
alias nd=nodemon
alias fr=forever
alias sna='nodemon | by'
alias search='ps aux | grep'

# redis related
alias redisd='redis-server '
alias redis='redis-cli '

alias ph='phantomjs'
alias s3='s3cmd'

alias mp='meteor -p '
alias mt='meteor'

alias sg='smartgithg.sh'

# restart window
alias wtf="source ~/.zshrc"

# let terminal speak for me with 's'
alias s="say -v 'vicki'"

# tells me my IP Address
alias myip='curl ip.appspot.com'

#directories aliases
alias ws="cd ~/workspace"
alias pc="cd ~/workspace/picasm/picasm"
alias dt="cd ~/dotfiles"
