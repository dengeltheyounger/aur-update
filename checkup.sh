#!/bin/bash

setuplog="setup.log"
logpath="updatelogs"
repolog="checkrepos.log"
searchresults="searchforupdates.log"
toupdate="outofdate.log"

# run checksetup and create log

echo "Checking setup"
if [ ! -d "$logpath" ]; then
	mkdir "$logpath"
fi

echo $(date) >> "$logpath"/"$setuplog"
./checksetup.sh >> "$logpath"/"$setuplog"
echo "Check complete. You will find the log in $logpath."

# Update list of foreign packages

sudo pacman -Qm > aurpackages.log

# run checkrepos and create log

echo "Checking repositories"
echo $(date) >> "$logpath"/"$repolog"
./checkrepos.sh >> "$logpath"/"$repolog"
code=$?

if [[ "$code" -eq 1 ]]; then
	echo "There repository was non-existent. You will find the log in $logpath."

else
	echo "Check successful. No errors discovered."
fi

# run searchforupdates and create log.

echo "Checking for updates. This may take a while."
echo $(date) >> "$logpath"/"$searchresults"
./searchforupdates.sh >> "$logpath"/"$searchresults"
code=$?

if [[ "$code" -eq 1 ]]; then
	echo "No match was found when searching through package list. You will find the log in $logpath."
fi

# If the list of packages to update exists and is not empty, then print list

if [ -f "$toupdate" ] && [ -s "$toupdate" ]; then
	echo "The following packages have updates available"
	while IFS= read -r package; do
		echo $(package="${%% *}")
	done
	
	echo "Enter the command \"update\" in order to use the update service."
	
else
	echo "All packages are up to date."
fi

exit 0
