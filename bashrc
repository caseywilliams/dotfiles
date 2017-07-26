#!/bin/bash
# vim: ai ts=2 sw=2 et sts=2 ft=sh

source $HOME/.dotfiles/bash/git-prompt.sh
export TERM=screen-256color

declare -a COLORS=(43 45 117 146 179 217 210 213 177)

set_color() {
  num=$(echo $1 | md5sum | grep -Eo "[[:digit:]]{3}" | head -n1)
  index=$((${num#0} % ${#COLORS[@]}))
  color="\033[38;5;"
  color+=${COLORS[$index]}
  color+="m\]"
  echo $color
}

export PS1="$(set_color $USER)\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[$(set_color `hostname`)\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;7m\][\[$(tput sgr0)\]\[$(set_color `uname -a`)\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\$(git_prompt)\n\[$(tput bold)\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

export PATH="./node_modules/.bin:$HOME/bin:$PATH"
export CDPATH=.:$HOME:$HOME/src

if [ -d $HOME/.nodenv ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi
if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

alias ls="ls --color=auto -F"
alias ll='ls -alF'
alias info="info --vi-keys"
alias be="bundle exec"
alias rsync="rsync --progress"
alias ..="cd .."
alias ...="cd ../.."

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

