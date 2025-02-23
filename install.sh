#!/bin/bash

to_delete=("vim" "tsch" "mksh")
to_install=(
  "fish" "starship" "atuin"
  "fzf" "eza" "gdu" "btop" "tzselect"
  "docker" "docker-copmpose" "containerd"
  "symbols-only-nerd-fonts" "unicode-emoji"
  # TODO: Proxy & config
  "fastfetch"
)

post_install_scripts()
{
  sudo chsh -s $(which fish) $USER
  starship preset no-nerd-font -o ~/.config/starship.toml

  sudo usermod -aG systemd-journal $USER
  sudo usermod -aG docker $USER
}

# # # # # # # # # # # # # # # # # # # # # # # # #
# LO REVIENTO AL QUE TOQUE DE ACÁ PARA ABAJO c: #
# # # # # # # # # # # # # # # # # # # # # # # # #

sudo SUSEConnect -p PackageHub/15.6/x86_64
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

git clone https://github.com/organizacionunaplauso/unaplauso-infra.git && rm -rf unaplauso-infra/.git
cp -rfv unaplauso-infra/. $HOME && rm -rf unaplauso-infra
sudo cp -rfv onRoot/. / && rm -rf onRoot

post_install_scripts
printf "\033c"
