#!/bin/sh
# Uhh this is the first shell script I've written in like, years

GEN="zshrc vimrc"
LINUX="xresources"
MAC="osx"

link_file()
{
  if [ -f $HOME/.$1 ]; then
    echo "Backing up your existing .$1 to .$1.original..."
    mv $HOME/.$1 $HOME/$1.original
  fi
  ln -s $PWD/$1 $HOME/.$1
}

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

echo "Done"
