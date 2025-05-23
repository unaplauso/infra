#!/bin/bash

SUSE_HUB_VER='PackageHub/15.6/x86_64'
INFRA_REPO='infra'

to_delete=("vim" "tsch" "mksh")
to_install=(
  "fish" "starship" "atuin" "fastfetch" "nano"
  "fzf" "bat" "eza" "gdu" "btop" "tzselect"
  "docker" "docker-compose" "containerd"
  "nginx" "firewalld" "certbot" "python3-certbot-nginx"
  "symbols-only-nerd-fonts" "unicode-emoji"
)

post_install_scripts()
{  
  sudo sysctl vm.swappiness=150
  sudo usermod -aG systemd-journal $USER

  sudo chsh -s $(which fish) $USER
  starship preset no-nerd-font -o $HOME/.config/starship.toml

  sudo systemctl enable docker
  sudo systemctl start docker
  sudo usermod -aG docker $USER

  # FIXME: FIREWALL ROMPE OAUTH

  sudo systemctl enable firewalld
  sudo systemctl start firewalld
  sudo firewall-cmd --permanent --add-service=http
  sudo firewall-cmd --permanent --add-service=https

  sudo systemctl enable nginx
  sudo systemctl start nginx

  sudo certbot certonly --nginx \
    -m lukacerrutti2002@gmail.com \
    -d unaplauso.app \
    --agree-tos -n -v

  sudo systemctl stop nginx
  sudo nginx -t -c $HOME/app/nginx.conf
  sudo nginx -c $HOME/app/nginx.conf
}

# # # # # # # # # # # # # # # # # # # # # # # # #
# LO REVIENTO AL QUE TOQUE DE ACÁ PARA ABAJO c: #
# # # # # # # # # # # # # # # # # # # # # # # # #

cd $HOME

sudo SUSEConnect -p $SUSE_HUB_VER
sudo zypper refresh
sudo zypper clean --all

for i in "${to_delete[@]}"
do
  sudo zypper rm -y -u --force-resolution --details "$i"
done

for i in "${to_install[@]}"
do
  sudo zypper in -y -l -f \
    --replacefiles --force-resolution \
    --no-recommends --allow-vendor-change --details "$i"
done

sudo zypper dup --remove-orphaned --no-recommends \
  --force-resolution --no-allow-vendor-change -l -y

cp -rfv $INFRA_REPO/. $HOME && rm -rf $INFRA_REPO
cd $HOME/app

post_install_scripts
# fish
