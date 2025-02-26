# VARIABLES & ALIASES

set -Ux APP_DIR $HOME/app
alias eenv='nano $APP_DIR/.env'

alias dui='$HOME/.local/bin/lazydocker'
alias gui='$HOME/.local/bin/lazygit'
alias d='docker'
alias dc='docker-compose'
alias dpullup='dc pull && dc up -d'
alias dprune='d system prune --volumes -a -f'
alias rproxy='sudo nginx -c $APP_DIR/nginx.conf -s reload -t'
alias renew='sudo certbot renew --pre-hook "systemctl stop nginx" --post-hook "systemctl start nginx"'

# CI/CD & TESTING FUNCTIONS

function deploy
  dpullup
  dprune
end

function pull-infra 
  cd $HOME
  git stash push
  git stash drop
  git pull
  cd $APP_DIR
end

function refresh-infra
  pull-infra
  dc down
  deploy
end

function proxy-test
  wget http://127.0.0.1:5000/api/health
  wget http://localhost/api/health
end

# --- ¡NO TOCAR DESDE ACÁ SIN SABER POR FA!

export TERM=xterm-256color
cd $APP_DIR

atuin init fish | source
starship init fish | source
sudo sysctl vm.swappiness=150
renew
rproxy

alias ls='eza --color=always --group-directories-first --icons -a -l'
alias cat='bat'
alias jctl='journalctl -p 3 -xb'
alias fzf='nano (command fzf --preview "cat {}")'
alias e='nano'
alias neofetch='fastfetch'
alias gdu='gdu -c --si $HOME'

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
