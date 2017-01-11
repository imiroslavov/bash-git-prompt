#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. "$(dirname ${BASH_SOURCE[0]})/config.sh"

CLEAN_PS1=$(echo "$DEFAULT_PS1" | sed "s/ *//g")

generate_prompt() {
	local PROMPT=$PROMPT_FORMAT;
	local STATUS=$(git rev-list --count --left-right "@{upstream}"...HEAD);
	
	PROMPT=$(echo $PROMPT | sed "s/%B%/$(git branch | grep -e '^\*' | awk '{print $2}')/")
	PROMPT=$(echo $PROMPT | sed "s/%M%/$(git status -s --porcelain | egrep -v '^\?\?' | grep -E '^.{0,1}[RM]' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%A%/$(git status -s --porcelain | egrep -v '^\?\?' | grep -E '^.{0,1}A' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%D%/$(git status -s --porcelain | egrep -v '^\?\?' | grep -E '^.{0,1}D' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%U%/$(git status -s --porcelain | egrep '^\?\?' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%C%/$(git status -s --porcelain | egrep -v '^\?\?' | grep -E '^.{0,1}U' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%S%/$(git stash list | wc -l)/")

	PROMPT=$(echo $PROMPT | sed "s/%+%/$(get_branch_status $(echo $STATUS | awk '{print $2}') $PROMPT_FORMAT_AHEAD)/")
	PROMPT=$(echo $PROMPT | sed "s/%-%/$(get_branch_status $(echo $STATUS | awk '{print $1}') $PROMPT_FORMAT_BEHIND)/")

	echo "$PROMPT"
}

get_branch_status() {
	local RESULT=""

	if [ $1 -gt 0 ]; then
		RESULT=$(echo $2 | sed "s/%N%/$1/")
	fi
	
	echo $RESULT
}

create_prompt() {
	if [ -d ".git" ] && $(git rev-parse --is-inside-work-tree 2>/dev/null); then
		local FORMAT=""
		if [ $PROMPT_MILTILINE -eq 1 ]; then
			FORMAT="$(generate_prompt)\n$DEFAULT_PS1"
		else
			FORMAT="$CLEAN_PS1 $(generate_prompt)\$ "
		fi

		export PS1=$FORMAT
	else
		export PS1=$DEFAULT_PS1
	fi
}

export PROMPT_COMMAND="create_prompt"
