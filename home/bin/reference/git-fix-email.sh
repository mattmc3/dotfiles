#!/usr/bin/env sh

# https://help.github.com/articles/changing-author-info/

git filter-branch --env-filter '

OLD_EMAIL="$WORK_EMAIL"
CORRECT_NAME="Matt McElheny"
CORRECT_EMAIL="$PERS_EMAIL"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
	export GIT_COMMITTER_NAME="$CORRECT_NAME"
	export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
	export GIT_AUTHOR_NAME="$CORRECT_NAME"
	export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
