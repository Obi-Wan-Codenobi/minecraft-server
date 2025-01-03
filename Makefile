CONTAINER_NAME=mc
IMAGE_NAME=itzg/minecraft-server
HOST_DIR=/home/kade/minecraft-server/minecraft-data
CONTAINER_DIR=/data

.PHONY: all
all: run

.PHONY: run
run:
	@echo "Starting container $(CONTAINER_NAME) using image $(IMAGE_NAME)..."
	sudo docker run --restart unless-stopped -d -v $(HOST_DIR):$(CONTAINER_DIR) -it --name $(CONTAINER_NAME) -p 25565:25565 -e EULA=TRUE $(IMAGE_NAME)

# For entering the minecraft server cli
.PHONY: cli
cli:	
	@echo "Entering minecraft server command line"
	sudo docker exec -i $(CONTAINER_NAME) rcon-cli

# For swapping worlds in minecraft
.PHONY: swap
swap:
	@echo "Swapping minecraft worlds"


.PHONY: clean
clean:
	@echo "Stopping container $(CONTAINER_NAME)..."
	sudo docker stop $(CONTAINER_NAME)
	@echo "Removing container $(CONTAINER_NAME)..."
	sudo docker rm $(CONTAINER_NAME)
	@echo "Removing all unused volumes"
	sudo docker volume prune

.PHONY: help
help:
	@echo "Makefile commands:"
	@echo "  make                             - Run minecraft server container"
	@echo "  make help                        - Show this help message"
