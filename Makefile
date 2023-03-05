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
		@hugo --environment production

##  > update & install module
update:
		@hugo mod tidy
		@hugo mod npm pack
		@npm install
		@hugo server -w