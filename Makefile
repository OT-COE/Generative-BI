REGISTRY := registry.ldc.opstree.dev
IMAGE_NAME := ai-coe/genbi
IMAGE_TAG := v1
IMAGE := $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

CONTAINER_NAME := genbi

.PHONY: all build push run stop remove-container clean up down test
all: build
test:
	@echo "No tests defined"

build:
	docker build -t $(IMAGE) .

push:
	docker push $(IMAGE)

run:
	- docker rm -f $(CONTAINER_NAME) 2>/dev/null || true
	docker run -d --name $(CONTAINER_NAME) -p 8000:8000 --env-file .env $(IMAGE)


stop:
	
	- docker rm -f $(CONTAINER_NAME) 2>/dev/null || true

remove-container:
	docker rm ${REGISTRY/$(IMAGE):${IMAGE_TAG}}

clean:
	docker rmi ${REGISTRY/$(IMAGE):${IMAGE_TAG}}

up: build run

down: stop clean

