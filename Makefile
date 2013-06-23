BASH_DIR=~/.bash
GIT_PROMPT_DIR=./bash_git
GIT_PROMPT_SCRIPT=./bash_git.sh

install:
	@if [ ! -d ${BASH_DIR} ]; then \
	    echo "Creating bash directory ${BASH_DIR}" ; \
	    mkdir ${BASH_DIR} ; \
	fi
	@if [ ! -d ${BASH_DIR}/${GIT_PROMPT_DIR} ]; then \
	    echo "Copying bash_git scripts into ${BASH_DIR}" ; \
	    cp -rfp ${GIT_PROMPT_DIR} ${BASH_DIR} ; \
	    cp -rfp ${GIT_PROMPT_SCRIPT} ${BASH_DIR} ; \
	else \
	    echo "The scripts are already installed" ; \
	fi

	@echo -e "You can enable bash_git by adding:\n"
	@echo -e "\t. ${BASH_DIR}/bash_git.sh\n"
	@echo "in your \"~/.bashrc\" file"
	@echo -e "or by executing:\n"
	@echo -e "\techo \". ${BASH_DIR}/bash_git.sh\" >> ~/.bashrc\n"
	@echo "in the command line"

clean:
	@if [ -d ${BASH_DIR}/${GIT_PROMPT_DIR} ]; then \
	    echo "Uninstalling bash_git..." ; \
	    rm -rf ${BASH_DIR}/${GIT_PROMPT_DIR} ${BASH_DIR}/${GIT_PROMPT_SCRIPT}; \
	    echo -e "You have to manually disable bash_git by removing:\n" ; \
	    echo -e "\t. ~/bash/bash_git.sh\n" ; \
	    echo "from your \"~/.bashrc\" file" ; \
	else \
	    echo "The scripts are not installed. You must run \"make install\" first" ; \
	fi

#For development purposes
update: clean install