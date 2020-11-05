
# if NVM is used then this should be used
if [ -f ~/.bash_aliases ]; then
  source ~/.nvm/nvm.sh
fi

# Shows the git branch in prompt
# export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \W\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] > 🏠"'

export PATH=$PATH:/home/abhijeet/apps-tools/phantomjs-1.9.7/bin:~/apps-tools/smartgithg-5_0_9/bin:./node_modules
export PATH="/usr/local/opt/openjdk/bin:$PATH"
# eval "$(thefuck --alias)"
# eval "$(thefuck --alias FUCK)"

export ANDROID_HOME=~/Library/Android/sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH