RUST_VERSION := 1.62
ALPINE_VERSION := 3.16.0

APPNAME := simple-rust-web-server
DOCKER_REPO := local
SERVER_PORT ?= 8080

.DEFAULT_GOAL := help
.PHONY: run docker-build docker-run docker-stop

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ \
	{ printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

run: ## Run app
	SERVER_PORT=$(SERVER_PORT) cargo run --release

docker-build: ## Build docker image
	docker build \
	--pull \
	--build-arg RUST_VERSION="$(RUST_VERSION)" \
	--build-arg ALPINE_VERSION="$(ALPINE_VERSION)" \
	--build-arg APPNAME="$(APPNAME)" \
	--tag="$(DOCKER_REPO)/$(APPNAME):latest" \
	.

docker-run: ## Run docker
	docker run -d --rm \
	--env SERVER_PORT=$(SERVER_PORT) \
	-p $(SERVER_PORT):$(SERVER_PORT) \
	--name $(APPNAME) \
	$(DOCKER_REPO)/$(APPNAME):latest && \
	docker ps

docker-stop: ## Stop docker
	docker stop $(APPNAME)
