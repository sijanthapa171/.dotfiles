# only run this code if the shell is interactive
case $- in
    *i*) ;;
      *) return;;
esac

alias ll='ls -lA'

alias g='git'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gps='git push'
alias gpsf='git push --force --no-verify'

alias dotfiles='code ~/.dotfiles'

alias reload-shell='source ~/.bashrc'

. "$HOME/.cargo/env"

eval "$(starship init bash)"
clear