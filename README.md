# Un Aplauso SUSE dotfiles

## 1. Docker Hub login

> - _Password will be requested_

```sh
docker login -u unaplauso
```

## 2. Clone repo

> - _Credentials will be requested_
> - Change branch to `latest` for testing environment

```sh
git clone --branch stable https://github.com/unaplauso/infra.git
```

### 3. Installation

```sh
./infra/install.sh
```

> Consider exiting & reconnecting

#### 4. `.env` setup

```sh
e .env
```

> Fill with environment variables

## 5. Start application :)

```sh
deploy
```
