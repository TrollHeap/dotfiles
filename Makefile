# ==================[ Config ]==================
DOTFILES ?= $(HOME)/dotfiles
ENV_ROOT := $(CURDIR)/env-files/.config/env-files
ENV_MODULES := $(ENV_ROOT)/modules
SCRIPTS_ROOT := $(CURDIR)/scripts/.config/scripts


# ==================[ Bootstrap ]==================
.PHONY: help

help:
	@echo "Available targets:"
	@awk '/^[a-zA-Z0-9_-]+:/ && !/^_/{print "-",$$(1)}' $(MAKEFILE_LIST) | sed 's/://'

# ==================[ Docs ]==================
.PHONY: ventoy konsave

ventoy:
	@command -v glow >/dev/null 2>&1 && glow $(DOTFILES)/docs/ventoy.md || less $(DOTFILES)/docs/ventoy.md

konsave:
	@command -v glow >/dev/null 2>&1 && glow $(DOTFILES)/docs/konsave.md || less $(DOTFILES)/docs/konsave.md

# ==================[ Bootstrap ]==================
.PHONY: bootstrap clean-boot dotfiles workspace launch-tor test-pkgs test-env-reload

bootstrap:
	@echo "🔧 Running full bootstrap..."
	bash $(ENV_ROOT)/bootstrap/init.sh

clean-boot:
	@echo "🧹 Cleaning init flags..."
	rm -f $(ENV_ROOT)/logs/.init_flags

dotfiles:
	@echo "🧩 Deploying dotfiles..."
	zsh $(ENV_ROOT)/modules/dotfiles/setup.sh

workspace:
	@echo "🗂️  Initializing workspace structure..."
	bash $(ENV_ROOT)/modules/workspace/setup.sh

# ==================[ Apps & tools install ]==================
.PHONY: install-konsave

install-konsave:
	@echo "🗂️  Installing konsave..."
	zsh $(SCRIPTS_ROOT)/tools/install-konsave.sh

# ==================[ tools install ]==================
.PHONY: launch-tor konsave-push

launch-tor:
	@echo "🗂️  Initializing a tor-browser session..."
	zsh $(SCRIPTS_ROOT)/appli/tor-browser/launch_tor.sh

konsave-push:
	@echo "🗂️  Installing konsave..."
	bash $(SCRIPTS_ROOT)/backup/push-konsave.sh

# ==================[ Test]==================
test-pkgs:
	bash $(ENV_ROOT)/core/verify_pkgs.sh || echo "💥 Verification failed"

test-env-reload:
	@echo "🧪 Testing env.sh reloading..."
	@unset C_ENV_LOADED && bash -c 'source $(ENV_ROOT)/core/env.sh'
