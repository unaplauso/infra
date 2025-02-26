# Un Aplauso SUSE dotfiles

## 1. Docker Hub login

> - _Password will be requested_

```sh
docker login -u unaplauso
```

## 2. Install git & clone repo

> - _Credentials will be requested_
> - Change branch to `latest` for testing environment

```sh
sudo zypper in -y -l -f --no-recommends git
git clone --branch stable https://github.com/unaplauso/infra.git
git config --global credential.helper store
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
