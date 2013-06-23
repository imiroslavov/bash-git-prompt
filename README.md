bash-git-prompt
===============

An informative and fancy bash prompt for Git users
NOTE: this code is written as quick as possible... use at your own risk

## Example

The prompt may look like the following:

* `[master][M:1]`: on branch `master`, 1 file changed/modified
* `[master][M:1, A:1]`: on branch `master`, 1 file modified, 1 file added
* `[master][M:1, N:2]`: on branch `master`, 1 file modified, 2 files untracked/new
* `[test][D:3, C:1]`: on branch `test`, 3 files deleted, 1 file conflicting
* `[master][S:1]`: on branch `master`, 1 file modified, 2 files untracked/new
* `[master+2]`: on branch `master`, ahead of remote by 2 commits
* `[master-1]`: on branch `master`, behind remote by 1 commit

## Prompt Structure

By default, the general appearance of the prompt is:

`[<branch><branch tracking>][<local status>]`

* Local Status
** `M:n` there are `n` changed/modified files
** `N:n` there are `n` untracked/new files
** `A:n` there are `n` added files
** `D:n` there are `n` deleted files
** `C:n` there are `n` conflicting files
** `S:n` there are `n` stashes
* Branch Tracking
** `+n` ahead of remote by `n` commits
** `-n` behind remote by `n` commits

## Instalation

### Installing
```
git clone git://github.com/imiroslavov/bash-git-prompt.git
cd bash-git-prompt
make install
```
### Uninstalling
```
cd bash-git-prompt
make install
```

## Configuration

You can edit the basic configuration in `~/.bash/bash_git/bash_git_config.sh`
