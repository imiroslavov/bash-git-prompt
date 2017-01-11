BASH_DIR:=$(HOME)/.bash
BASHRC:=$(HOME)/.bashrc
GIT_PROMPT_DIR:=bash-git-prompt
GIT_PROMPT_CONFIG:=config.sh
GIT_PROMPT_SCRIPT:=prompt.sh

all:	update

install:
	if [ ! -f $(GIT_PROMPT_CONFIG) ]; then \
		cp $(GIT_PROMPT_CONFIG).default $(GIT_PROMPT_CONFIG); \
	fi;
	mkdir -p $(BASH_DIR)/$(GIT_PROMPT_DIR)
	cp -rut $(BASH_DIR)/$(GIT_PROMPT_DIR) $(GIT_PROMPT_CONFIG) $(GIT_PROMPT_SCRIPT) themes/
ifeq ("$(findstring $(GIT_PROMPT_SCRIPT),$(shell cat $(BASHRC)))","")
	echo ". $(BASH_DIR)/$(GIT_PROMPT_DIR)/$(GIT_PROMPT_SCRIPT)" >> $(BASHRC)
endif
	. $(BASHRC)
clean:
	rm -rfv $(BASH_DIR)/$(GIT_PROMPT_DIR)
	@echo "You need to manually edit $(BASHRC) file to completely remove $(GIT_PROMPT_SCRIPT)"


update:	clean install

