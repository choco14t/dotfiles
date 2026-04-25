SOURCE_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CHEZMOI ?= $(or $(shell command -v chezmoi 2>/dev/null),$(HOME)/.local/bin/chezmoi)

.DEFAULT_GOAL := help
.PHONY: help init deploy apply diff status update

init: ## Install chezmoi if it is missing
	@if [ ! -x "$(CHEZMOI)" ]; then \
		mkdir -p "$(HOME)/.local/bin"; \
		sh -c "$$(curl -fsLS get.chezmoi.io)" -- -b "$(HOME)/.local/bin"; \
	fi

deploy: apply ## Apply dotfiles with chezmoi

apply: ## Apply dotfiles with chezmoi
	@$(CHEZMOI) apply --source "$(SOURCE_DIR)"

diff: ## Show pending chezmoi changes
	@$(CHEZMOI) diff --source "$(SOURCE_DIR)"

status: ## Show pending chezmoi changes as a summary
	@$(CHEZMOI) status --source "$(SOURCE_DIR)"

update: ## Fetch changes for this repository
	git pull origin master
	$(CHEZMOI) apply --source "$(SOURCE_DIR)"

help: ## Show all the targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
