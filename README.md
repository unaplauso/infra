# Un Aplauso SUSE dotfiles

## 1. Private repo login

> - _Credentials will be requested_

```sh
aws configure
aws ecr get-login-password --region sa-east-1 | sudo \
  docker login --username AWS --password-stdin 908027417939.dkr.ecr.sa-east-1.amazonaws.com
```

## 2. Install git & clone repo

> - _Credentials will be requested_
> - Change branch to `latest` for testing environment

```sh
sudo zypper in -y -l -f --no-recommends git
git config --global credential.helper store
git clone --branch stable https://github.com/unaplauso/infra.git
```

## 3. Installation

```sh
chmod +x ./infra/install.sh
./infra/install.sh
```

> [!IMPORTANT]  
> Exit & reconnect for usermods to apply

## 4. `.env` setup

```sh
eenv
```

> Fill with environment variables

## 5. Start application :)

```sh
deploy
```

---

### General docs & aliases

Read [fish config](.config/fish/config.fish) for details.
