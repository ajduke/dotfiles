
# if NVM is used then this should be used
if [ -f ~/.bash_aliases ]; then
  source ~/.nvm/nvm.sh
fi

if [ -f "$HOME/.shell_aliases" ]; then
  source "$HOME/.shell_aliases"
elif [ -f "$HOME/dotfiles/bash/shell_aliases" ]; then
  source "$HOME/dotfiles/bash/shell_aliases"
fi

if declare -F show_ajduke_banner >/dev/null 2>&1; then
  show_ajduke_banner
fi

# Shows the git branch in prompt
# export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \W\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] > 🏠"'

# eval "$(thefuck --alias)"
# eval "$(thefuck --alias FUCK)"
eval "$(rbenv init -)"