
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

alias mkgd=mkgit_dir
