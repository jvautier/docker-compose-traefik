.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

infos:
	@echo "DEFAULT_NETWORK=${DEFAULT_NETWORK}"
	@echo "ENV=${ENV}"
	@echo "DOMAIN=${DOMAIN}"
	@echo "COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME}"
	cd ${ENV} && docker-compose config
	docker info
	
setup:
	docker network create traefik_net

deps-localhost:
	sudo mkdir -p /data/hosts/${DOMAIN}/traefik/certs
	sudo mkdir -p /data/hosts/${DOMAIN}/traefik/letsencrypt
	sudo -E mkcert -cert-file /data/hosts/${DOMAIN}/traefik/certs/local-cert.pem -key-file /data/hosts/${DOMAIN}/traefik/certs/local-key.pem "*.docker.localhost" "*.dailymars.localhost" "*.jvautier.localhost" "*.rockawooly.localhost" 

deploy:
	cd ${ENV} && \
	docker-compose down -v && \
	docker-compose up -d && \
	docker-compose logs -f

remove: ## Clean
	docker-compose down -v
	docker system prune -f