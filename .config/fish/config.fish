# VARIABLES & ALIASES

set -Ux APP_DIR $HOME/app
alias eenv='nano $APP_DIR/.env'

alias dui='$HOME/.local/bin/lazydocker'
alias d='docker'
alias dc='docker-compose'
alias dpullup='dc pull && dc up -d'
alias dprune='d system prune --volumes -a -f'

# CI/CD FUNCTIONS

function deploy
  cd $APP_DIR
  dpullup
  dprune
end

function refresh-infra
  cd $HOME
  git pull
  cd $APP_DIR
  dc down
  deploy
end

# --- ¡NO TOCAR DESDE ACÁ SIN SABER POR FA!

export TERM=xterm-256color
cd $APP_DIR

atuin init fish | source
starship init fish | source
sudo sysctl vm.swappiness=150

alias ls='eza --color=always --group-directories-first --icons -a -l'
alias cat='bat'
alias jctl='journalctl -p 3 -xb'
alias fzf='nano (command fzf --preview "cat {}")'
alias e='nano'
alias neofetch='fastfetch'

alias fm='spf'
function spf
  set -gx SPF_LAST_DIR "$HOME/.local/state/superfile/lastdir"
  $HOME/.local/bin/spf $(pwd)
  if test -f "$SPF_LAST_DIR"
      source "$SPF_LAST_DIR"
      rm -f -- "$SPF_LAST_DIR" > /dev/null
  end
end

function fish_greeting
  clear
  fastfetch
  echo '---------------------------------------------------'
  echo 'MÁS TE VALE SABER LO QUE ESTÁS HACIENDO. Atte; Luka'
end
