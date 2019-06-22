# consul-config

## windows
in `Cmder`:
> export COMPOSE_CONVERT_WINDOWS_PATHS=1

start services:
> docker-compose up -d

check status in web:
> http://localhost:8500

or cli:
> docker exec -t consul1 consul members
