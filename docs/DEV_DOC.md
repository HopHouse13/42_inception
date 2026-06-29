# DEV_DOC

Developer guide.

## Prerequisites

- Docker, Docker Compose, Make
- `/etc/hosts`: `127.0.0.1   pbret.42.fr`
- Required folders on the host: `/home/pbret/data/{mariadb, wordpress, .env}`

## Setup

```bash
git clone <repository_url>
cd inception
make
```

## Makefile

| Command | Action |
|---|---|
| `make` | Copies the `.env`, builds and starts |
| `make down` | Stops and removes containers + network |
| `make stop` / `make start` | Pause / restart |
| `make re` | Rebuilds everything |
| `make clean` | Prunes Docker + removes volumes and data |
## commands

```bash
# Docker Images
docker build -t <image_name> <Dockerfile_path>       # build an image from a Dockerfile
docker run -it <image_name>                          # run a container in interactive mode
docker rmi <image_name>                              # remove an image
docker image ls                                      # list images

# Docker Containers
docker container ps                                  # list running containers
docker exec -it <container_id> /bin/sh               # enter a container shell
docker start <container>                             # start a stopped container
docker stop <container>                              # stop a running container
docker rm -f <container>                             # force-remove a container

# Networks
docker network ls                                    # list networks

# Volumes
docker volume ls                                     # list volumes
docker volume inspect <volume>                       # inspect a volume (path on the host)

# Docker Compose
docker compose -f <compose_file_path> up -d --build  # build and start in the background
docker compose -f <compose_file_path> down           # stop and remove containers + network
docker compose -f <compose_file_path> start          # restart stopped containers
docker compose -f <compose_file_path> stop           # pause the containers
docker compose -f <compose_file_path> ps             # show containers status

# Modern cmd
docker init				# Automatically generates a Dockerfile, compose.yaml, and .dockerignore based on the service technology you choose
docker compose watch	# Watches your source code and updates the container on the fly
docker debug			# Integrates a debug shell into any container/image, even without a built-in shell. Brings its own toolbox (vim, curl, htop, etc)
docker buildx cloud		# Remote Docker image build management (faster, lighter)
```

## Database (MariaDB)

### Enter the MariaDB container
```sh
docker exec -it mariadb /bin/sh
```

### Connect to MariaDB
```sh
mariadb -h localhost -u root -p$SQL_ROOT_PASSWORD   # connect as root
```

### Common queries
```sql
SHOW DATABASES;                  -- list all databases
USE <database_name>;             -- select a database
SHOW TABLES;                     -- list tables of the selected database
SELECT * FROM <table_name>;      -- display all rows of a table
```

## Admin access

- WordPress admin: https://pbret.42.fr/wp-admin/

## Data persistence

```
/home/pbret/data/mariadb    -> /var/lib/mysql
/home/pbret/data/wordpress  -> /var/www/wordpress
```

Data survives container rebuilds and machine reboots: stopping the containers
(`make stop`) or removing them (`make down`) keeps the volumes intact.  
Only `make clean` removes the volumes and wipes all data to start fresh.