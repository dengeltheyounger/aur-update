#!/bin/bash

if [ ! -f ~/.aurconfig ]; then
	"aurpath=\"/usr/src/AUR\"" > ~/.aurconfig
fi

# Path to aur-update
updatepath=$(pwd)
# Path to the aur-update logs
logpath="${updatepath}/updatelogs"
setuplog="${logpath}/setup.log"
repolog="${logpath}/checkrepos.log"
searchresults="${logpath}/searchforupdates.log"
toupdate="${updatepath}/outofdate.log"

# aur-update does not come with a log directory. It will create one on first run
echo "Checking setup"
if [ ! -d "$logpath" ]; then
	mkdir "$logpath"
fi

# Each aur-update log will be preceeded by a date and time stamp
# run checksetup and create log
echo $(date) >> "$setuplog"
./checksetup.sh >> "$setuplog"

echo "Check complete. You will find the log in ${logpath}."

# Update list of foreign packages
sudo pacman -Qm > aurpackages.log

# run checkrepos and create log
echo "Checking repositories"
echo $(date) >> "$repolog"
./checkrepos.sh >> "$repolog"
code=$?

if [[ "$code" -eq 1 ]]; then
	echo "There was a repository that was non-existent. You will find the log in ${logpath}."
else
	echo "Check successful. No errors discovered."
fi

# run searchforupdates and create log.
echo "Checking for updates. This may take a while."
echo $(date) >> "$searchresults"
./searchforupdates.sh >> "$searchresults"
code=$?

if [[ "$code" -eq 1 ]]; then
	echo "No match was found when searching through package list. You will find the log in ${logpath}."
fi

# If the list of packages to update exists and is not empty, then print list
if [ -f "$toupdate" ] && [ -s "$toupdate" ]; then
	echo "The following packages have updates available"
	while IFS= read -r package; do
		echo $(package="${%% *}")
	done
	
	echo "If you wish to update, you will need to run the update script."
	
else
	echo "All packages are up to date."
fi

exit 0
