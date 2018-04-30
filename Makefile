.PHONY: all
all: build

setup:
IMAGE_NAME = matto/gunicorn
IMAGE_VERSION = 0.1.0
CURRENT_DIR = $(shell pwd)

build: setup
	docker build --tag ${IMAGE_NAME}:${IMAGE_VERSION} .

run: setup
	docker run --rm \
	  -p 5000:5000 \
		--name gunicorn \
		${IMAGE_NAME}:${IMAGE_VERSION}

login: setup
	docker exec -it gunicorn /bin/bash
