#!/bin/bash

DEFAULT_PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

#%B% - branch name
#%+% - commits ahead
#%-% - commits behind
#%S% - stashes
#%M% - modified files
#%U% - untracked files
#%A% - staged files
#%D% - deleted files
#%C% - conflicts

PROMPT_FORMAT="(%B%%-%%+%)[÷%S%±%M%+%U%·%A%-%D%×%C%]"
#PROMPT_FORMAT="[%B%%-%%+%][S:%S%][M:%M%|U:%U%|A:%A%|D:%D%|C:%C%]"
#PROMPT_FORMAT="[%B%%-%%+%][S:%S%][M:%M%,U:%U%,A:%A%,D:%D%,C:%C%]"

#%+% - commits ahead format
PROMPT_FORMAT_AHEAD="↑%N%"
#PROMPT_FORMAT_AHEAD="+%N%"

#%-% - commits behind format
PROMPT_FORMAT_BEHIND="↓%N%"
#PROMPT_FORMAT_BEHIND="-%N%"

PROMPT_MILTILINE=0
