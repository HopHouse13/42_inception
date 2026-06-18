# USER_DOC

Basic usage guide (end user / administrator).

## Start / stop the stack

| Command | Action |
|---|---|
| `make` | Starts the stack |
| `make stop` | Pauses the containers |
| `make start` | Restarts them |
| `make down` | Stops and removes them |

## Access

- Website: `https://pbret.42.fr`
- Admin: `https://pbret.42.fr/wp-admin`

HTTPS only (a self-signed certificate warning will appear: this is normal,
accept it).

## Credentials

Defined in the `.env` file (`/home/pbret/data/`, gitignored). To change them:
edit `.env`, then run `make re`.

## Check

```bash
docker compose -f srcs/docker-compose.yml ps
```

All three containers must show the `Up` status.
