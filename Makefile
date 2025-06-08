.PHONY: all bootstrap clean-boot verify dotfiles workspace remnote

export DOTFILES ?= $(HOME)/dotfiles
ENV_ROOT := $(CURDIR)/env-files/.config/env-files
SCRIPTS_ROOT := $(CURDIR)/scripts/.config/scripts

bootstrap:
	@echo "🔧 Running full bootstrap..."
	bash $(ENV_ROOT)/bootstrap/init.sh

clean-boot:
	@echo "🧹 Cleaning init flags..."
	rm -f $(ENV_ROOT)/logs/.init_flags

verify:
	bash $(ENV_ROOT)/core/verify_pkgs.sh || echo "💥 Verification failed"

dotfiles:
	@echo "🧩 Deploying dotfiles..."
	zsh $(ENV_ROOT)/modules/dotfiles/setup.sh

workspace:
	@echo "🗂️  Initializing workspace structure..."
	bash $(ENV_ROOT)/modules/workspace/setup.sh

remnote:
	@echo "🗂️  Initializing install remnote application..."
	zsh $(SCRIPTS_ROOT)/appli/remnote/install_remnote.sh

tor-browser:
	@echo "🗂️  Initializing a tor-browser session..."
	zsh $(SCRIPTS_ROOT)/appli/tor-browser/launch_tor.sh
