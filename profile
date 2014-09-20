export EDITOR="vim"
export VISUAL="$EDITOR"
export BROWSER="chromium"
export TERM="urxvt"
export LESS="-iQsR"
export PAGER="less"
export GREP_OPTIONS="--color=auto"
export GREP_COLOR='1;30'

case `uname` in
Linux)
  setxkbmap -option caps:swapescape
  xset r rate 255
  ;;
esac
