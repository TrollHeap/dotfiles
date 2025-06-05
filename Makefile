.PHONY: all bootstrap os tools shell dotfiles workspace clean

ENV_ROOT := $(CURDIR)/env-files/.config/env-files

all: bootstrap

bootstrap:
	@echo "🔧 Running full bootstrap..."
	bash $(ENV_ROOT)/bootstrap/init.sh

os:
	@echo "⚙️  Setting up OS-specific environment..."
	@if [ -z "$(OS)" ]; then \
		echo "❌ Please pass OS=ubuntu|arch|macos"; exit 1; \
	fi
	bash $(ENV_ROOT)/modules/os/$(OS).sh

tools:
	@echo "🔧 Installing core tools..."
	bash $(ENV_ROOT)/modules/tools/setup.sh

shell:
	@echo "🐚 Setting up shell environment..."
	bash $(ENV_ROOT)/modules/shell/zsh.sh
	bash $(ENV_ROOT)/modules/shell/ohmyzsh.sh

dotfiles:
	@echo "🧩 Deploying dotfiles..."
	bash $(ENV_ROOT)/modules/dotfiles/setup.sh

workspace:
	@echo "🗂️  Initializing workspace structure..."
	bash $(ENV_ROOT)/modules/workspace/setup.sh

clean:
	@echo "🧹 Cleaning init flags..."
	rm -f $(ENV_ROOT)/logs/.init_flags
