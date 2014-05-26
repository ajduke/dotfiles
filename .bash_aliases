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

alias lw='cd ~/workspace/projects/LinkWokV3'
alias rd=~/workspace/projects/reader_api
alias startmongo='sudo mongod -f /etc/mongodb.conf --fork'
alias stopmongo='sudo mongod -f /etc/mongodb.conf --shutdown'
alias by='bunyan -o short'
alias slw='source config/env.sh;meteor'

# redis related 

alias redisd='redis-server '
alias redis='redis-cli ' 
