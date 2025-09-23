REGISTRY := registry.ldc.opstree.dev
IMAGE_NAME := ai-coe/genbi
IMAGE_TAG := v1
IMAGE := $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)
CONTAINER_NAME=genbi

build:
	docker build -t $(IMAGE) .

push:
	docker push $(IMAGE)
run:
	@if [ $$(docker ps -q -f name=$(CONTAINER_NAME)) ]; then \
		echo "Stopping existing container..."; \
		docker stop $(CONTAINER_NAME); \
		docker rm $(CONTAINER_NAME); \
	fi
	docker run -d --name ${CONTAINER_NAME} -p 8000:8000 --env-file .env ${REGISTRY}/$(IMAGE_NAME):${IMAGE_TAG}

push: 
	docker push ${REGISTRY}/$(IMAGE_NAME):${IMAGE_TAG}

stop:
	@if [ $$(docker ps -q -f name=$(CONTAINER_NAME)) ]; then \
		docker stop $(CONTAINER_NAME); \
		docker rm $(CONTAINER_NAME); \
	else \
		echo "No running container named $(CONTAINER_NAME)"; \
	fi

remove-container:
	docker rm ${REGISTRY/$(IMAGE):${IMAGE_TAG}}

clean:
	docker rmi ${REGISTRY/$(IMAGE):${IMAGE_TAG}}

up: build run

down: stop clean

