source ~/.dotfiles/zsh/antigen/antigen.zsh

# teehee
antigen bundles <<EOBUNDLES
git
heroku
zsh-users/zsh-completions src
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting
sindresorhus/pure
EOBUNDLES
bindkey -e

if [ -f $HOME/.zsh_aliases ]; then
  source $HOME/.zsh_aliases
fi

case `uname` in
  Linux)
    alias ls="ls -F --color"
    ;;
  Darwin)
    alias ls="ls -FG"
    [ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
    ;;
esac
alias b="bundle exec"

if [ -d $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)" > /dev/null 2>&1
fi
if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

export NVM_DIR="/home/cawil/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

agent () {
  [ $1 ] && KEY="$1" || KEY="id_rsa"
  ssh-agent sh -c "ssh-add ~/.ssh/$KEY && $SHELL"
}

up () {
  TEMP_PWD=`pwd`
  while ! [ -d .git ]; do
    cd ..
  done
  OLDPWD=$TEMP_PWD
}
