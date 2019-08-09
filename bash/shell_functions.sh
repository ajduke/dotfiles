
mkgit_dir () {
  printf "What would you like to name your repository? "
  read name
  #Replace with a local path to your repos
  cd $HOME/workspace/hub
  mkdir $name
  cd $name
  git init
  #Replace with local paths to any default files you'd like to include
  #Note: the -f flag forces overwrite; use -i for interactivity if you prefer
  cp -f "$HOME/dotfiles/git/git-init/README.md" .
  echo "$name \n----" > README.md
  cp -f "$HOME/dotfiles/git/git-init/LICENSE" .
  cp -f "$HOME/dotfiles/git/gitignore" .gitignore
  hub create
  git add .
  git commit -m "First commit: add README, LICENSE, and .gitignore."
  git push -u origin master
  hub browse
}

get_jest_base () {
  echo "Do you want to clone jest-base into ${PWD} directory, confirm, y/n? "
  read confirm

  if [ "$confirm" = 'y' ]
  then
    chalk-animation --duration 2000 rainbow  'Starting cloning repo 🚀'
    git clone git@github.com:ajduke/jest-base.git .
    sudo rm -rf .git
    chalk-animation --duration 2000 rainbow  'Starting npm install 🚌'
    npm i 
    chalk-animation --duration 2000 rainbow  'Done 🎊 🎉'
  else
    chalk-animation rainbow --duration 2000 'Closing the session 🙏'
  fi
}

mkdir_cd () {
  if [ -z "$1" ]
  then 
    chalk blue bold 'Enter directory name..'
    read dir_name
    mkdir $dir_name
    cd $dir_name
  else 
    mkdir $1
    cd $1
  fi
}


alias mkcd=mkdir_cd
alias get_jb=get_jest_base
alias mkgd=mkgit_dir
