export EDITOR="vim"
export VISUAL="$EDITOR"
export BROWSER="chromium"
export TERM="rxvt-256color"
export LESS="-iQsR"
export PAGER="less"
export GREP_OPTIONS="--color=auto"
export GREP_COLOR='1;30'
export PATH=$HOME/.rbenv/bin:$PATH

case `uname` in
Linux)
  setxkbmap -option caps:swapescape
  if [ -f $HOME/.config/yoga/touch-sensitivity.sh ]; then
    source $HOME/.config/yoga/touch-sensitivity.sh &
  fi
  xrdb -load $HOME/.Xresources
  xset r rate 255
  ;;
esac
