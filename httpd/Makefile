CURRENT_DIR = $(shell pwd)

BASENAME = $(shell basename $(CURRENT_DIR))
IMAGE_NAME = eurasia36/httpd-apps:latest
CONTAINER_NAME = $(BASENAME)_1

SOURCE_DIR  = $(CURRENT_DIR)/src
TARGET_DIR  = $(CURRENT_DIR)/target

default: build

# CLEAN

clean:
	rm -rf $(TARGET_DIR)

## INIT

init:
	mkdir -p $(TARGET_DIR)

## COMPILE

compile: init
	make -C eurasia36_kz/         TARGET_DIR=$(TARGET_DIR) compile
	make -C payment_eurasia36_kz/ TARGET_DIR=$(TARGET_DIR) compile

## BUILD

build: clean docker-build

## RUN, START, STOP

docker-build: compile
	docker build -t $(IMAGE_NAME) -f $(CURRENT_DIR)/Dockerfile $(TARGET_DIR)

run: docker-build
	mkdir -p $(TARGET_DIR)/sites/html
	docker run -it -p 80:80 -p 443:443 -v $(TARGET_DIR)/sites:/var/www $(IMAGE_NAME)

start: docker-build
	mkdir -p $(TARGET_DIR)/sites/html
	docker run -d  -p 80:80 -p 443:443 -v $(TARGET_DIR)/sites:/var/www --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	docker container stop $(CONTAINER_NAME)
	docker container rm $(CONTAINER_NAME)

restart:
	docker container restart $(CONTAINER_NAME)
