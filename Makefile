.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

setup: ## Setup certs with mkcert and docker network
	mkcert -cert-file etc/certs/local-cert.pem -key-file etc/certs/local-key.pem "*.docker.localhost" "*.domain.localhost"
	docker network create traefik

serve: clean setup | ## Serve
	docker-compose up -d --remove-orphans
	docker-compose logs -f

clean: ## Clean
	docker-compose down -v
	docker system prune -f