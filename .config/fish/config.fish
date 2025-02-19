alias inn='sudo zypper in --no-recommends'
alias uni='sudo zypper rm --clean-deps'
alias jctl="journalctl -p 3 -xb"
alias untar='tar -zxvf '

alias efish='nano $HOME/.config/fish/config.fish'
alias envapi='nano $HOME/app/.env.api'
alias envweb='nano $HOME/app/.env.web'

alias ls='eza --color=always --group-directories-first --icons -a -l'
alias fz='nano (fzf --preview "cat {}")'
alias fm=spf
alias e=nano

alias dui=$HOME/.local/bin/lazydocker
alias d=docker
alias dc='docker compose'
alias dprune='d system prune --volumes -a -f &'
alias deploy-stable='dc up -d --pull always -f stable-compose.yml && dprune'
alias deploy-latest='dc up -d --pull always -f latest-compose.yml && dprune'

function refresh-infra
  cd $HOME
  git pull
  cd $HOME/app
end

export TERM=xterm-256color
cd $HOME/app
atuin init fish | source
starship init fish | source

function spf
  set -gx SPF_LAST_DIR "$HOME/.local/state/superfile/lastdir"
  command spf $(pwd)
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
