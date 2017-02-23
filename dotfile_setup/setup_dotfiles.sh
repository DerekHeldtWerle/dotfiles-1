#!/bin/bash

function dotfiles {
   git --git-dir=$HOME/.files/ --work-tree=$HOME $@
}

[[ -f ~/.bashrc ]] && rm ~/.bashrc
[[ -f ~/.bash_profile ]] && rm ~/.bash_profile

git clone --bare git@github.com:tkinz27/dotfiles $HOME/.files

mkdir -p .files-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dotfiles.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .files-backup/{}
fi;

system=$(uname -s)

if [ "Darwin" == "$system" ]; then
    echo "***** MAC *****";
    brew tap 'homebrew/bundle'
    brew bundle
elif [ "Linux" == "$system" ]; then
    echo "***** LINUX *****";
    command -v "apt-get" && pkg=apt-get || pkg=yum
    $pkg install zsh
    curl -sL zplug.sh/installer | zsh
else
    echo "ON A NOT SUPPORTED SYSTEM.";
fi
