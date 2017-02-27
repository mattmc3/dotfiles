#!/bin/bash

# Script for adding a git checkin to a cron job

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
