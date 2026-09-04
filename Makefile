LOCAL_UID := $(shell id -u)
LOCAL_GID := $(shell id -g)
export LOCAL_UID
export LOCAL_GID

.PHONY: prepare-env setup test ci dev down build push run-production

prepare-env:
	cp -n .env.example .env

setup: prepare-env
	docker-compose run --rm app make setup

test: prepare-env
	docker-compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

ci: prepare-env
	docker compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

dev: prepare-env
	docker-compose up

down:
	docker-compose down

build: prepare-env
	docker-compose -f docker-compose.yml build app

push: prepare-env
	docker-compose -f docker-compose.yml push app

run-production:
	docker run --rm -p 8080:8080 -e NODE_ENV=development kimdeun/devops-engineer-from-scratch-project-74 make dev
