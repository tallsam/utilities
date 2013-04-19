#!/bin/bash

###
 # Blow away the local copy and replace it with the UAT/Prod site.
 #
 ##

# Info on rsync & drush aliases

# Drush aliases, set up in drush aliases files.
LOCAL_ALIAS='@grains'
UAT_ALIAS='@grains.dev'

# Path to drush. --debug for verbose output, -y so we dont have to arm the keyboard.
DRUSH='drush -y'

# Neat use of drush to give us the site's files directory.
FILES="`drush dd $LOCAL_ALIAS:%files`"

# Sync the database.
# If using Ubuntu and sync is real slow check: http://t.co/kBcIMZ6F
$DRUSH sql-sync --source-dump=/root/tr.sql --target-dump=/var/aegir/tr.sql --sanitize-password='123' $UAT_ALIAS $LOCAL_ALIAS

# Sync the local copy from the uat copy, including the git directory.
# Exclude drushrc.php to avoid messy conflicts.
# $DRUSH rsync --include-vcs --exclude-paths='drushrc.php' $UAT_ALIAS $LOCAL_ALIAS
cd "`drush dd $LOCAL_ALIAS`"
git pull

# Sync the uat files directory with the local files directory.
# Note that this grabs the /sites/trhomes.itomicpowered.com/files dir
# and copies it to /sites/trhomes.shogun.com/files,
# which can't be done with the normal rsync command.
# http://soundpostmedia.com/article/drush-tip-quickly-sync-files-between-your-environments-rsync
# ** Need to define %files in alias files. **
$DRUSH rsync $UAT_ALIAS:%files $LOCAL_ALIAS:%files --mode='O'

# Revert all features to what is in code.
# Don't need this if we are cloning the live db.
#$DRUSH $LOCAL_ALIAS fra

# Run any database updates (shouldn't be any).
$DRUSH updb

# Set permissions on the files directory so imagecache will work.
chmod 777 $FILES -R

# Disable all the performance caches.
$DRUSH $LOCAL_ALIAS vset cache 0
$DRUSH $LOCAL_ALIAS vset preprocess_css 0
$DRUSH $LOCAL_ALIAS vset preprocess_js 0

# Disable IHF module to avoid infinite redirects when sites are live.
$DRUSH $LOCAL_ALIAS dis ihf

# Enable Dev Modules.
$DRUSH $LOCAL_ALIAS en devel views_ui

# Clear the cache.
$DRUSH $LOCAL_ALIAS cc all

