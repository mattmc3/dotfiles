#!/usr/bin/env sh

# https://help.github.com/articles/changing-author-info/

# export GITFIX_OLD_EMAIL="foo@bar.com"
# export GITFIX_NEW_EMAIL="foobar@baz.com"
# export GITFIX_OLD_NAME="Namey Name"
# export GITFIX_NEW_NAME="New Namey"

git filter-branch --env-filter '
if [ "$GIT_COMMITTER_EMAIL" = "$GITFIX_OLD_EMAIL" ]
then
	export GIT_COMMITTER_NAME="$GITFIX_NEW_NAME"
	export GIT_COMMITTER_EMAIL="$GITFIX_NEW_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$GITFIX_OLD_EMAIL" ]
then
	export GIT_AUTHOR_NAME="$GITFIX_NEW_NAME"
	export GIT_AUTHOR_EMAIL="$GITFIX_NEW_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
