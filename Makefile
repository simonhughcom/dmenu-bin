PROJECT_NAME := "dmenu-bin"
PREFIX := /usr/local
SRC_PREFIX := ./src
SRC := $(patsubst $(SRC_PREFIX)/%, %, $(wildcard ./src/*.sh))
INSTALL_PATH := $(patsubst %.sh, $(PREFIX)/bin/%, $(SRC))

.PHONY: all
all:
	@echo "==== $(PROJECT_NAME) ===="
	@echo
	@echo "Run 'make install' to install all scripts."
	@echo
	@echo "Run 'make install-SCRIPT' to install individual scripts."
	@echo "For example: 'make install-$(word 1, $(SRC))' to install the $(word 1, $(SRC)) script."

## install : Install all scripts.
.PHONY: install
install: $(patsubst %, install_%, $(SRC))
	@echo
	@echo "Finished installing $(PROJECT_NAME)!"

## uninstall : Uninstall all scripts.
.PHONY: uninstall
uninstall: $(patsubst $(PREFIX)/bin/%, uninstall_%, $(INSTALL_PATH))
	@echo
	@echo "Finished uninstalling $(PROJECT_NAME)!"

## install-SCRIPT : Install individual script.
.PHONY: install_%
install-%: $(SRC_PREFIX)/%
	@echo "Installing $@..."
	@cp -vp $< $(PREFIX)/bin/$(notdir $(basename $<))
	@chmod 755 $(PREFIX)/bin/$(notdir $(basename $<))

## uninstall-SCRIPT : Uninstall individual script.
.PHONY: uninstall_%
uninstall-%: $(PREFIX)/bin/%
	@echo "Uninstalling $<..."
	@rm -vf $<

## variables : Print variables.
.PHONY: variables
variables:
	@echo PROJECT_NAME: $(PROJECT_NAME)
	@echo SRC_PREFIX:   $(SRC_PREFIX)
	@echo PREFIX:       $(PREFIX)
	@echo SRC:          $(SRC)
	@echo INSTALL_PATH: $(INSTALL_PATH)

## help : Print help message.
.PHONY: help
help: Makefile
	@sed -n 's/^## //p' $< | awk -F':' '{printf "%-30s: %s\n", $$1, $$2'}
