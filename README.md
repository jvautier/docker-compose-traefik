# docker-compose traefik

Docker-compose stack with [traefik](https://docs.traefik.io/)

> NB: 
> 
> *.localhost should resolve to 127.0.0.1 on firefox and chrome without tricks with /etc/hosts or dnsmask ...

## Requirements

- installed [mkcert](https://github.com/FiloSottile/mkcert)
- installed [docker-compose](https://docs.docker.com/compose/)

## Setup

```sh
make setup
```

## Usages

```sh
docker-compose up -d
```

```sh
docker-compose logs -f
```

or 

```sh
make serve
```

Open traefik at [https://traefik.docker.localhost/dashboard/#/](https://traefik.docker.localhost/dashboard/#/) or [http://localhost:8080/dashboard/#/](http://localhost:8080/dashboard/#/)
