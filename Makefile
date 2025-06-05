.PHONY: all bootstrap dotfiles workspace verify backup_zen restore_zen clean

export DOTFILES := $(HOME)/dotfiles
ENV_ROOT := $(CURDIR)/env-files/.config/env-files
SCRIPTS_ROOT := $(CURDIR)/scripts/.config/scripts

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

backup_zen:
	sh $(SCRIPTS_ROOT)/zen_browser/backup_zen_full.sh

backup_zen:
	sh $(SCRIPTS_ROOT)/zen_browser/restore_zen_full.sh

clean:
	@echo "🧹 Cleaning init flags..."
	rm -f $(ENV_ROOT)/logs/.init_flags
