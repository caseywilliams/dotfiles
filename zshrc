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

if [ -f $HOME/.zsh_aliases ]; then
  source $HOME/.zsh_aliases
fi

case `uname` in
  Linux)
    alias ls="ls -F --color"
    ;;
  Darwin)
    alias ls="ls -FG"
    source /opt/boxen/env.sh
    ;;
esac

eval "$(rbenv init -)" &> /dev/null
export NVM_DIR="/home/cawil/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
