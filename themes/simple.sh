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

PROMPT_FORMAT="[%B%%-%%+%][÷%S%±%M%+%U%·%A%-%D%×%C%]"

#%+% - commits ahead format
PROMPT_FORMAT_AHEAD="↑%N%"

#%-% - commits behind format
PROMPT_FORMAT_BEHIND="↓%N%"

