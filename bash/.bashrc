
# if NVM is used then this should be used
if [ -f ~/.bash_aliases ]; then
  source ~/.nvm/nvm.sh
fi

# Shows the git branch in prompt
# export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \W\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] > 🏠"'

# eval "$(thefuck --alias)"
# eval "$(thefuck --alias FUCK)"
eval "$(rbenv init -)"