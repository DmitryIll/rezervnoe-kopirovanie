#!/bin/sh

# This script does personal backups to a rsync backup server. You will end up
# with a incremental backup. The incrementals will go
# into subdirectories named as date, and the current
# full backup goes into a directory called "current"

clear

# source directory
BDIR=/home/$USER/
# excludes file - this contains a wildcard pattern per line of files to exclude
EXCLUDES=$HOME/cron/excludes

# destination
# the name of the backup machine
BSERVER=158.160.32.142
ROOTBACKUPDIR="/backups"

########################################################################

BACKUPTIMEDIR=`date +%Y-%m-%d-%H%M%S`
ssh "$USER@$BSERVER" "test -d $ROOTBACKUPDIR/$USER/inc/$BACKUPTIMEDIR/ || mkdir -p $ROOTBACKUPDIR/$USER/inc/$BACKUPTIMEDIR"

ssh "$USER@$BSERVER" "cd $ROOTBACKUPDIR/$USER/inc&&ls -t | tail -n +6 | xargs rm -rf --"

OPTS="--force --ignore-errors --delete-excluded --exclude-from=$EXCLUDES --delete --backup --backup-dir=$ROOTBACKUPDIR/$USER/inc/$BACKUPTIMEDIR ->

#export PATH=$PATH:/bin:/usr/bin:/usr/local/bin

# now the actual transfer
echo "rsync $OPTS $BDIR $BSERVER:$ROOTBACKUPDIR/$USER/current"
rsync $OPTS $BDIR $BSERVER:$ROOTBACKUPDIR/$USER/current

