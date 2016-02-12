case `uname` in
Linux)
  if [ -f $HOME/.config/yoga/touch-sensitivity.sh ]; then
    source $HOME/.config/yoga/touch-sensitivity.sh &
  fi
  if [ $DISPLAY ]; then
    xrdb -load $HOME/.Xresources
    xset r rate 255
  fi
  ;;
esac
