.DEFAULT_GOAL := all

UID = $(shell id -u ${USER})
GID = $(shell id -g ${USER})

build:
	docker compose build --progress=plain

run:
	docker compose run --env UID=${UID} --env GID=${GID} stm32-cubemx

all:
	docker compose run --build --env UID=${UID} --env GID=${GID} stm32-cubemx
