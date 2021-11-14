#!/bin/bash
# vim: ai ts=2 sw=2 et sts=2 ft=sh

#######
# Paths
#######

export GOPATH=$HOME/.local/src/go
export GOBIN="$GOPATH/bin"
export ANDROID_SDK_HOME="$HOME/Android/Sdk"
export PATH="$HOME/bin:$HOME/.nodenv/bin:$HOME/.nodenv/shims:./node_modules/.bin:$HOME/.dotfiles/bin:$ANDROID_SDK_HOME/cmdline-tools/latest/bin:$GOBIN:$PATH"

#########
# History
#########
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups
shopt -s histappend
shopt -s cmdhist
shopt -s lithist
shopt -s histreedit
shopt -s histverify
shopt -s extglob

_bash_history_sync() {
    builtin history -a         #1
    HISTFILESIZE=$HISTSIZE     #2
}

history() {
    _bash_history_sync
    builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

# Instead of using control-s for flow control, pass it to readline to enable
# forward incremental search
[[ $- == *i* ]] && stty stop ""

######################
# Default applications
######################

export EDITOR=vim
export TERM=xterm-256color
export MANPAGER='less -s -R -M +Gg'
export HOSTALIASES="$HOME/.hosts"

export PAGER='less -R'
export LESS='-R'
export LESSOPEN='|~/.dotfiles/lessfilter %s'
# See https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

####################
# Aliases, functions
####################

alias please=sudo
alias pls=sudo
alias ag="ag -Q"
alias ..="cd .."
alias ...="cd ../.."
alias be="bundle exec"
alias bi="bundle install"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias g="git"
alias gi="git"
alias gitspell-setup="ln -s ~/.dotfiles/git/pre-commit-spell-check .git/hooks/pre-commit"
alias grep="grep --color=auto"
alias info="info --vi-keys"
alias ll="ls -lah"
alias l="ls"
alias rsync="rsync --progress"


case "$(uname)" in
  'Linux')
    alias ls="ls --color=auto -F"
    alias clip="xclip -selection c"
    alias i3lock="i3lock -c 000000"
    ;;
  'Darwin')
    alias ls="ls -GF"
    ;;
  *)
    ;;
esac

a () {
  [ $1 ] && KEY="$1" || KEY="id_rsa"
  ssh-agent sh -c "ssh-add ~/.ssh/$KEY && $SHELL"
}

#############
# Completions
#############

command -v kitty >/dev/null 2>&1 && source <(kitty + complete setup bash)

# System completions
for file in /etc/bash_completion; do
  [ -f $file ] && source $file
done

# Custom completions
for f in $HOME/.dotfiles/bash/completions/*; do
  source $f;
done

###########
# Tool init
###########

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -d $HOME/.nodenv ]; then
  eval "$(nodenv init -)"
  source <(npm completion)
  export NODE_VERSION="$(nodenv version-name)"
  export PATH="$HOME/.nodenv/bin:$HOME/.nodenv/versions/$NODE_VERSION/bin:$PATH"
fi

if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi

if [[ -d $HOME/.cargo ]]; then
  source $HOME/.cargo/env
fi

###################
# Prompt and colors
###################

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

source $HOME/.dotfiles/bash/git-prompt.sh

declare -a COLORS=(43 45 117 146 179 217 210 213 177)

set_color() {
  num=$(echo $1 | md5sum | grep -Eo "[[:digit:]]{3}" | head -n1)
  index=$((${num#0} % ${#COLORS[@]}))
  color="\033[38;5;"
  color+=${COLORS[$index]}
  color+="m\]"
  echo $color
}

timer_start() {
  timer=${timer:-$SECONDS}
}

timer_stop() {
  local timer_value=$(($SECONDS - $timer))
  timer_show="$(pretty_print_time $timer_value)"
  unset timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

pretty_print_time() {
  ((hours=${1}/3600))
  ((minutes=(${1}%3600)/60))
  ((seconds=${1}%60))
  if [ "$hours" != "0" ]; then
    printf " %dh%dm%ds" $hours $minutes $seconds
  elif [ "$minutes" != "0" ]; then
    printf " %dm%ds" $minutes $seconds
  elif [ "$seconds" -gt "3" ]; then
    printf " %ds" $seconds
  fi
}

prompt_last_status() {
  local status="$?"
  if [ "$status" != "0" ]; then
    printf " \033[38;5;8m%s$(tput sgr0)" $status
  fi
}

prompt_time="\[\033[38;5;8m\]\${timer_show}\[$(tput sgr0)\]"
prompt_username="\[$(set_color $USER)\u\[$(tput sgr0)\]"
prompt_hostname="\[$(set_color $(hostname))\h\[$(tput sgr0)\]"
prompt_at="\[\033[38;5;15m\]@\[$(tput sgr0)\]"
prompt_path="\[\033[38;5;15m\]\[$(tput sgr0)\]\[\033[38;5;7m\][\[$(tput sgr0)\]\[$(set_color `uname -a`)\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\[$(tput sgr0)\]"
prompt_git="\[\033[38;5;15m\]\$(git_prompt)"
# prompt_char="\[$(tput bold)\]❯\[$(tput sgr0)\] \[$(tput sgr0)\]"
prompt_char="\[$(tput bold)\]$\[$(tput sgr0)\] \[$(tput sgr0)\]"

export PS1="${prompt_username}${prompt_at}${prompt_hostname} ${prompt_path}\$(prompt_last_status)${prompt_time}\$(git_prompt)\n${prompt_char}"

if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi
