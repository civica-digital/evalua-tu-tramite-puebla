.PHONY: deploy provide build update clean

HOST ?= urbem-puebla-staging
APP_DIR ?= /var/www/urbem-puebla
COMPOSE := docker-compose -f $(APP_DIR)/docker-compose.production.yml

deploy: provide build update clean ## Run the deploy strategy (provide, build, update, clean)

provide: docker-compose.production.yml .env ## Provide the HOST with whole repository
	tar czf - . | ssh $(HOST) tar xzf - -C $(APP_DIR)

build: ## Build the Docker image inisde the HOST
	ssh $(HOST) $(COMPOSE) build web

update: ## Update the containers and run migrations
	ssh $(HOST) $(COMPOSE) down
	ssh $(HOST) $(COMPOSE) up -d
	ssh $(HOST) $(COMPOSE) run --rm web rake db:setup db:migrate

clean: ## Remove images that are not being used by any container
	ssh $(HOST) "docker image prune -f"

.env:
	@cp -p .env.example .env

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
