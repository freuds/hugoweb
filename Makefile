SHELL:=/bin/bash -eu

export PATH := $(PATH):/usr/local/bin

# variables definition
HUGO_BINARY = $(shell which hugo)

HUGO_NAME = ANSIBLE_FOLDER = _tools/ansible

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

##########################################################################
## This command manage helm release with the cluster Kubernetes
## Usage:
##	make <service>-<command>
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
##  > make dev : launch Hugo in development mode
dev: clear
		@$(HUGO_BINARY) -D server

