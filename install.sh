#!/bin/sh
# Uhh this is the first shell script I've written in like, years

GEN="zshrc vimrc"
LINUX="xresources"
MAC="osx"

link_file()
{
  if [ -f $HOME/.$1 ]; then
    if [ -L $HOME/.$1 ]; then
      unlink $HOME/.$1
    else
      echo "Backing up your existing .$1 to .$1.original..."
      mv $HOME/.$1 $HOME/.$1.original
    fi
  fi
  ln -s $PWD/$1 $HOME/.$1
}


echo "Setting up dotfiles..."

for file in $GEN; do
  link_file $file
done

if [ ! -d $HOME/.vim ]; then
  mkdir $HOME/.vim
fi
cp -r vim/snippets $HOME/.vim/

if [ `uname -s` = 'Darwin' ]; then
  for file in $MAC; do
    link_file $file
  done
fi

if [ `uname -s` = 'Linux' ]; then
  for file in $LINUX; do
    link_file $file
  done
fi

if [ ! -d $HOME/.nvm ]; then
  read -p "Want to install NVM? (yn) " yn
  case $yn in
    [Yy]* )
      git clone https://github.com/creationix/nvm.git $HOME/.nvm
      cd $HOME/.nvm
      git checkout `git describe --abbrev=0 --tags` 1> /dev/null
      cd - 1> /dev/null
      ;;
    * ) exit;;
  esac
fi

echo "Done"
