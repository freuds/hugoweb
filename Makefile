SHELL:=/bin/bash -eu

export PATH := $(PATH):/usr/local/bin

# define standard colors
BLACK        := $(shell tput -Txterm setaf 0)
RED          := $(shell tput -Txterm setaf 1)
GREEN        := $(shell tput -Txterm setaf 2)
YELLOW       := $(shell tput -Txterm setaf 3)
LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
PURPLE       := $(shell tput -Txterm setaf 5)
BLUE         := $(shell tput -Txterm setaf 6)
WHITE        := $(shell tput -Txterm setaf 7)
RESET        := $(shell tput -Txterm sgr0)

.PHONY: help
default: help

# OS detection
OS := Linux
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	OS = Linux
endif
ifeq ($(UNAME_S),Darwin)
	OS = macOS
endif

# ARCH detection
ARCH := 64bit
UNAME_P := $(shell uname -m)
ifeq ($(UNAME_P),x86_64)
	ARCH = 64bit
endif
ifeq ($(UNAME_P),arm64)
	ARCH = ARM64
endif

# hugo docker args
#HUGO_BINARY = hugo_extended
HUGO_BINARY = hugo
HUGO_VERSION = 0.96.0
HUGO_FILENAME = $(HUGO_BINARY)_$(HUGO_VERSION)_$(OS)-$(ARCH).tar.gz
HUGO_ENV = production

# NGINX args
NGINX_PORT = 5000

# hugoweb variables
NAME = hugoweb
VERSION = $(shell cat VERSION)
CONTAINER_NAME = $(NAME)_$(VERSION)

##########################################################################
## This command manage hugoweb release
## Usage:
##	make <command>
##
## Available Commands:
##
##  > help : Display help for this command (default)
##
help:
		@cat $(MAKEFILE_LIST) | grep ^\#\# | grep -v ^\#\#\# |cut -c 4-

clear:
		@clear
## ----------------------------------------------------------------------
##  > dev : launch Hugo in development mode
dev: clear
		@hugo -D server

##  > generate : Generate public code with Hugo
generate:
		@hugo --environment $(HUGO_ENV)

##  > docker : build docker image
image:
		@docker build \
			--build-arg HUGO_VERSION="$(HUGO_VERSION)" \
			--build-arg HUGO_FILENAME="$(HUGO_FILENAME)" \
			--build-arg HUGO_ENV="$(HUGO_ENV)" \
			--build-arg NGINX_PORT="$(NGINX_PORT)" \
			--no-cache \
			-f Dockerfile \
			-t $(NAME):$(VERSION) .

##  > run : launch Hugo from docker image
run:
		@docker run -d -p 1313:$(NGINX_PORT) --name $(CONTAINER_NAME) $(NAME):$(VERSION)

##  > shell : shell exec on running container
shell:
		@container_id=$$(docker ps -q --filter="NAME=$(CONTAINER_NAME)") ; \
		docker exec -ti $${container_id} sh
