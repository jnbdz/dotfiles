include config.mk

OS ?= none

.PHONY: all
all: ## Please set OS var to select the distro you want to setup. Use OS=qubes, OS=kali, or OS=rocky.
	@$(MAKE) -C $(OS)

# Alternatively, if you specifically need to include Makefiles rather than calling them
# You can conditionally include them like this:

ifeq ($(OS),qubes-os)
include qubes/Makefile
else ifeq ($(OS),kali)
include kali/Makefile
else ifeq ($(OS),rocky)
include rocky/Makefile
else
$(error OS variable is not set correctly. Use OS=qubes, OS=kali, or OS=rocky.)
endif

.PHONY: help
help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/Makefile://' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
