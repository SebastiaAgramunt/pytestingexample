.SILENT:
.DEFAULT_GOAL := help

PROJECT := Python testing example (Author Sebastia Agramunt)

COLOR_RESET = \033[0m
COLOR_COMMAND = \033[36m
COLOR_YELLOW = \033[33m
COLOR_GREEN = \033[32m
COLOR_RED = \033[31m

IMAGE_NAME=datascience
CONTAINER_NAME=notebook
PORT=8888

## Test function basicfunction
test_discover:
	@echo "${COLOR_GREEN}----\nBuilding docker image ${IMAGE_NAME}...\n----\n${COLOR_RESET}"
	#python -m unittest test/test_basicfunction.py -v
	python -m unittest discover -v
	@echo "finished something"

## Test all of the functions that have test
test_function:
	python -m unittest discover -v

## Prints help message
help:
	printf "\n${COLOR_YELLOW}${PROJECT}\n------\n${COLOR_RESET}"
	awk '/^[a-zA-Z\-\_0-9\.%]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "${COLOR_COMMAND}$$ make %s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort
	printf "\n"