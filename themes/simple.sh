#!/bin/bash

DEFAULT_PS1="\u@\h:\w"

#%B% - branch name
#%+% - commits ahead
#%-% - commits behind
#%S% - stashes
#%M% - modified files
#%U% - untracked files
#%A% - staged files
#%D% - deleted files
#%C% - conflicts

PROMPT_FORMAT="[%B%%-%%+%][S:%S%,M:%M%,U:%U%,A:%A%,D:%D%,C:%C%]"

#%+% - commits ahead format
PROMPT_FORMAT_AHEAD="+%N%"

#%-% - commits behind format
PROMPT_FORMAT_BEHIND="-%N%"

