.PHONY: all bootstrap os tools shell dotfiles workspace clean

export DOTFILES := $(HOME)/dotfiles
ENV_ROOT := $(CURDIR)/env-files/.config/env-files

bootstrap:
	@echo "🔧 Running full bootstrap..."
	bash $(ENV_ROOT)/bootstrap/init.sh

dotfiles:
	@echo "🧩 Deploying dotfiles..."
	bash $(ENV_ROOT)/modules/dotfiles/setup.sh

workspace:
	@echo "🗂️  Initializing workspace structure..."
	bash $(ENV_ROOT)/modules/workspace/setup.sh

verify:
	bash $(ENV_ROOT)/core/verify_pkgs.sh || echo "💥 Verification failed"

clean:
	@echo "🧹 Cleaning init flags..."
	rm -f $(ENV_ROOT)/logs/.init_flags
