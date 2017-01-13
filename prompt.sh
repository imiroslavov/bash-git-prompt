#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. "$(dirname ${BASH_SOURCE[0]})/config.sh"
. "$(dirname ${BASH_SOURCE[0]})/themes/$PROMPT_THEME.sh"

CLEAN_PS1=$(echo "$DEFAULT_PS1" | sed "s/ *//g")

generate_prompt() {
	local PROMPT=$PROMPT_FORMAT
	local STATUS=$(git status --branch --porcelain)
	local BRANCH_INFO=$(printf -- '%s\n' "${STATUS[@]}" | head -1)

	PROMPT=$(echo $PROMPT | sed "s/%B%/$(get_branch_name "$BRANCH_INFO")/")
	PROMPT=$(echo $PROMPT | sed "s/%M%/$(printf -- '%s\n' "${STATUS[@]}" | egrep -v '^\?\?' | grep -E '^.{0,1}[RM]' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%A%/$(printf -- '%s\n' "${STATUS[@]}" | egrep -v '^\?\?' | grep -E '^.{0,1}A' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%D%/$(printf -- '%s\n' "${STATUS[@]}" | egrep -v '^\?\?' | grep -E '^.{0,1}D' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%U%/$(printf -- '%s\n' "${STATUS[@]}" | egrep '^\?\?' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%C%/$(printf -- '%s\n' "${STATUS[@]}" | egrep -v '^\?\?' | grep -E '^.{0,1}U' | wc -l)/")
	PROMPT=$(echo $PROMPT | sed "s/%S%/$(git stash list | wc -l)/")

	PROMPT=$(echo $PROMPT | sed "s/%+%/$(get_branch_status "$BRANCH_INFO" "$PROMPT_FORMAT_AHEAD" 'ahead')/")
	PROMPT=$(echo $PROMPT | sed "s/%-%/$(get_branch_status "$BRANCH_INFO" "$PROMPT_FORMAT_BEHIND" 'behind')/")

	echo "$PROMPT"
}

get_branch_status() {
	local RESULT=""
	local COUNT=$(echo $1 | sed -n "s/.*$3 \([0-9]\).*/\1/p")

	if [ ${#COUNT} -gt 0 ]; then
		RESULT=$(echo $2 | sed "s/%N%/$COUNT/")
	fi
	
	echo $RESULT
}

get_branch_name() {
	local BRANCH=$(echo $1 | sed -n 's/## \(.*\)\.\.\.\(.*\)/\1/p')

	if [[ ! $BRANCH ]]; then
		BRANCH=$(echo $1 | sed -n 's/## HEAD (\(.*\))/\1/p')
	fi

	if [[ ! $BRANCH ]]; then
		BRANCH=$(echo $1 | sed -n 's/## Initial commit on \(.*\)/\1/p')
	fi

	echo $BRANCH
}

create_prompt() {
	if $(git rev-parse --is-inside-work-tree 2>/dev/null); then
		local FORMAT=""
		if [ $PROMPT_MILTILINE -eq 1 ]; then
			FORMAT="$(generate_prompt)\n$DEFAULT_PS1\\$ "
		else
			FORMAT="$CLEAN_PS1$(generate_prompt)\\$ "
		fi

		export PS1=$FORMAT
	else
		export PS1="$DEFAULT_PS1\\$ "
	fi
}

export PROMPT_COMMAND="create_prompt"
