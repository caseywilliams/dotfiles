#!/bin/sh

GEN="zshrc vimrc zprofile gitignore"
LINUX="Xresources Xmodmap"
MAC="osx"
NOLINK="gitconfig"

type git >/dev/null 2>&1 || { echo >&2 "You need to install git first.\n"; exit 1; }
type zsh >/dev/null 2>&1 || { echo >&2 "You need to install zsh first.\n"; exit 1; }

link_file()
{
  if [ -f $HOME/.$1 ]; then
    if [ -h $HOME/.$1 ]; then
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

if [ ! -d $HOME/.vim/autoload ]; then
  mkdir -p $HOME/.vim/autoload
fi
curl -fLo $HOME/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ `uname -s` = 'Darwin' ]; then
  for file in $MAC; do
    link_file $file
  done
fi

if [ `uname -s` = 'Linux' ]; then
  for file in $LINUX; do
    link_file $file
  done
  if [ ! -d $HOME/.fonts ]; then
    mkdir $HOME/.fonts
    git clone https://github.com/powerline/fonts.git $HOME/.fonts/powerline-fonts
  fi
  read -p "Want to install a gtk3 theme? (yn) " yn
  case $yn in
    [Yy]* )
      if [ ! -d $HOME/.themes ]; then
        mkdir $HOME/.themes
      fi
      curl -s https://raw.githubusercontent.com/xenlism/minimalism/master/INSTALL/online.install > /tmp/install-minimalism-theme
      bash /tmp/install-minimalism-theme
      ;;
    * ) exit;;
  esac
fi

if [ ! -d $HOME/.nodenv ]; then
  read -p "Want to install nodenv? (yn) " yn
  case $yn in
    [Yy]* )
      git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv
      cd $HOME/.nodenv && src/configure && make -C src && cd -
      git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build
      ;;
    * ) exit;;
  esac
fi

if [ ! -d $HOME/.rbenv ]; then
  read -p "Want to install rbenv? (yn) " yn
  case $yn in
    [Yy]* )
      git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
      cd $HOME/.rbenv && src/configure && make -C src && cd -
      git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
      ;;
    * ) exit;;
  esac
fi

echo "Done"
