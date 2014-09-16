#!/bin/sh
# Uhh this is the first shell script I've written in like, years

GEN="zshrc vimrc profile"
LINUX="xresources"
MAC="osx"
NOLINK="gitconfig"

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

for file in $GEN; do
  link_file $file
done

for file in $NOLINK; do
  if [ -f $HOME/.$file ]; then
    if [ -L $HOME/.$1 ]; then
      unlink $HOME/.$1
    else
      echo "Backing up your existing .$file to .$file.original..."
      mv $HOME/.$file $HOME/.$file.original
    fi
  fi
  cp $file $HOME/.$file
done

read -p "Do you want to set your git email? (y/n) " yn
case $yn in
  [Yy]* )
    read -p "Okay, which address do you want to use? " address
    git config --global user.email $address
    ;;
  *) ;;
esac

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
