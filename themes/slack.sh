#!/bin/bash

DEFAULT_PS1="\[\033[1;97m\]\u\[\033[38;5;172m\]@\[\033[1;97m\]\h\[\033[38;5;172m\]:\[\033[90m\]\w\033[0m"

#%B% - branch name
#%+% - commits ahead
#%-% - commits behind
#%S% - stashes
#%M% - modified files
#%U% - untracked files
#%A% - staged files
#%D% - deleted files
#%C% - conflicts

PROMPT_FORMAT="\[\033[38;5;172m\][\[\[\033[1;97m\]%B%%-%%+%\[\033[38;5;172m\]][\[\033[90m\]÷\[\033[1;97m\]%S%\[\033[90m\]±\[\033[1;97m\]%M%\[\033[90m\]+\[\033[1;97m\]%U%\[\033[90m\]·\[\033[1;97m\]%A%\[\033[90m\]-\[\033[1;97m\]%D%\[\033[90m\]×\[\033[1;97m\]%C%\[\033[38;5;172m\]]\033[0m"

#%+% - commits ahead format
PROMPT_FORMAT_AHEAD="\\\[\\\033[90m\\\]↑\\\[\\\033[1;97m\\\]%N%"

#%-% - commits behind format
PROMPT_FORMAT_BEHIND="\\\[\\\033[90m\\\]↓\\\[\\\033[1;97m\\\]%N%"

