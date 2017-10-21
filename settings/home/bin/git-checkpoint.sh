#!/bin/bash

# Script for adding a git checkin to a cron job

# Example
# run git-checkpoint at 5 after every hour from 8AM to 9PM
# 5 8-21 * * * ~/bin/git-checkpoint.sh ~/Dropbox/notes >/tmp/cron_notes.log 2>/tmp/cron_notes.err

workdir=$1
echo $workdir

if [ ! -d $workdir ]; then
	echo "Dir missing: $workdir" 1>&2
	exit -1
fi
cd $workdir
git add .
git commit -a -m "checkpoint @ `date '+%F %T'`"
git push -u origin master
