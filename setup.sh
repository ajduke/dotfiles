#!/bin/bash
#
# setup.sh
#
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

########## Variables

# dotfiles directory
dir=~/dotfiles

# old dotfiles backup directory
olddir=~/.dotfiles_old

# files to symlink
# format: "source_in_dotfiles_repo destination_in_home"
declare -a files_to_link=(
    "zshell/zshrc .zshrc"
    "bash/.bashrc .bashrc"
    "bash/shell_aliases .shell_aliases"
    "tmux/tmux.conf .tmux.conf"
    "git/gitconfig .gitconfig"
    "git/gitignore .gitignore"
    "node/npmrc .npmrc"
    "mongo/.mongorc.js .mongorc.js"
)

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd "$dir" || exit
echo "...done"

# move any existing dotfiles in homed-ir to dotfiles_old directory, then create symlinks
for entry in "${files_to_link[@]}"; do
    # split the entry into source and destination
    read -r source dest <<< "$entry"

    source_path="$dir/$source"
    dest_path="$HOME/$dest"

    echo "Processing $dest_path..."

    # if the destination file exists, back it up
    if [ -f "$dest_path" ] || [ -h "$dest_path" ]; then
        echo "Moving existing dotfile from $dest_path to $olddir"
        mv "$dest_path" "$olddir/"
    fi

    echo "Creating symlink for $source_path at $dest_path"
    ln -s "$source_path" "$dest_path"
    echo "...done"
done

echo "Setup complete."
