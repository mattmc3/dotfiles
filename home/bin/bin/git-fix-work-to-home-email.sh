#!/usr/bin/env bash
# https://help.github.com/articles/changing-author-info/

GITURL=${GITURL-github.com}

fatalerror() {
	echo $@ >&2
	exit 1
}

if [ -z $PERS_EMAIL ]
then
	fatalerror "\$PERS_EMAIL not set"
fi
if [ -z "$WORK_EMAIL" ]
then
	fatalerror "\$WORK_EMAIL not set"
fi
if [ -z "$PERS_USERNAME" ]
then
	fatalerror "\$PERS_USERNAME not set"
fi

if [ -z "$1" ]
then
	fatalerror "expecting git repo"
fi

if [[ "$1" == *"/"* ]]
then
	owner=${1%/*}
	repo=${1##*/}
else
	owner=$PERS_USERNAME
	repo=${1}
fi

if [[ -d "$HOME/Downloads/gitfix" ]]; then
	rm -rf "$HOME/Downloads/gitfix"
fi
mkdir -p "$HOME/Downloads/gitfix"
cd "$HOME/Downloads/gitfix"
echo "git clone --bare git@${GITURL}:${owner}/${repo}.git"
git clone --bare git@${GITURL}:${owner}/${repo}.git
cd "$HOME/Downloads/gitfix/${repo}.git"

git filter-branch --env-filter '

OLD_NAME="$MYNAME"
OLD_EMAIL="$WORK_EMAIL"
CORRECT_NAME="$PERS_USERNAME"
CORRECT_EMAIL="$PERS_EMAIL"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ] || [ "$GIT_COMMITTER_NAME" = "$OLD_NAME" ]
then
	export GIT_COMMITTER_NAME="$CORRECT_NAME"
	export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ] || [ "$GIT_AUTHOR_NAME" = "$OLD_NAME" ]
then
	export GIT_AUTHOR_NAME="$CORRECT_NAME"
	export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

echo "run these commands - don't forget to \`git config-pers\`"
echo "cd \"\$HOME/Downloads/gitfix/${repo}.git\""
echo "git push --force --tags origin 'refs/heads/*'"
