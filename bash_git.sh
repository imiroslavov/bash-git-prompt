#!/bin/bash -x

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

BASH_DIR=~/.bash
GIT_PROMPT_DIR=./bash_git

. "${BASH_DIR}/${GIT_PROMPT_DIR}/bash_git_config.sh"

DEFAULT_PS1="${PS1}"
PROMPT_PS1=$(echo "${DEFAULT_PS1}" | sed 's/ *//g')

function init_prompt {
    PROMPT_SEPARATOR=""
    PROMPT_PREFIX="${GIT_PROMPT_PREFIX}"
    PROMPT_SUFFIX=
}

function update_git_branch_commits_count {
    GIT_BRANCH_COMMITS_COUNT=$(echo "${GIT_BRANCH_STATUS}" | grep -o "[0-9]*")
}

#@TODO: Display both ahead and behind
function update_git_branch_status {
    GIT_BRANCH_STATUS=$(git status | grep -e "^# Your branch is")
    if $(echo "${GIT_BRANCH_STATUS}" | grep 'ahead' > /dev/null); then
        update_git_branch_commits_count
        GIT_BRANCH_STATUS="+${GIT_BRANCH_COMMITS_COUNT}"
    elif $(echo "${GIT_BRANCH_STATUS}" | grep 'behind' > /dev/null); then
        update_git_branch_commits_count
        GIT_BRANCH_STATUS="-${GIT_BRANCH_COMMITS_COUNT}"
    else
        GIT_BRANCH_STATUS=""
    fi
}

function update_git_variables {
    GIT_MODIFIED=$(git status -s --porcelain | egrep -v "^\?\?" | grep -E "^.{0,1}[RM]" | wc -l)
    GIT_ADDED=$(git status -s --porcelain | egrep -v "^\?\?" | grep -E "^.{0,1}A" | wc -l)
    GIT_DELETED=$(git status -s --porcelain | egrep -v "^\?\?" | grep -E "^.{0,1}D" | wc -l)
    GIT_UNTRACKED=$(git status -s --porcelain | egrep "^\?\?" | wc -l)
    GIT_CONFLICTING=$(git status -s --porcelain | egrep -v "^\?\?" | grep -E "^.{0,1}U" | wc -l)
    GIT_BRANCH=$(git branch | grep -e "^\*" | awk '{print $2}')
    GIT_STASH=$(git stash list | wc -l)

    update_git_branch_status
}

function append_to_prompt {
    if [ $1 -gt 0 ] ; then 
        GIT_PROMPT="${GIT_PROMPT}${PROMPT_PREFIX}${PROMPT_SEPARATOR}$3$2:$1${GIT_PROMPT_COLOR_NONE}"
        PROMPT_SEPARATOR=${GIT_PROMPT_SEPARATOR}
        PROMPT_PREFIX=""
        PROMPT_SUFFIX=${GIT_PROMPT_SUFFIX}
    fi
}

function create_git_prompt {
    if $(git ls-files ./ --error-unmatch >/dev/null 2>/dev/null); then
        init_prompt
        update_git_variables

        GIT_PROMPT="${PROMPT_PS1}${GIT_PROMPT_PREFIX}${GIT_PROMPT_BRANCH}${GIT_BRANCH}${GIT_BRANCH_STATUS}${GIT_PROMPT_COLOR_NONE}${GIT_PROMPT_SUFFIX}"

        append_to_prompt ${GIT_MODIFIED}    "M" ${GIT_PROMPT_MODIFIED}
        append_to_prompt ${GIT_UNTRACKED}   "N" ${GIT_PROMPT_UNTRACKED}
        append_to_prompt ${GIT_ADDED}       "A" ${GIT_PROMPT_ADDED}
        append_to_prompt ${GIT_DELETED}     "D" ${GIT_PROMPT_DELETED}
        append_to_prompt ${GIT_CONFLICTING} "C" ${GIT_PROMPT_CONFLICTING}
        append_to_prompt ${GIT_STASH}       "S" ${GIT_PROMPT_STASH}

        export PS1="${GIT_PROMPT}${PROMPT_SUFFIX}\$ "
    else
        export PS1="${DEFAULT_PS1}"
    fi
}

export PROMPT_COMMAND="create_git_prompt"
