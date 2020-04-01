#!/bin/bash

checkup() {

	# Path to the aur-update logs
	local logpath="${aurupdate}/updatelogs"
	local setuplog="${logpath}/setup.log"
	local repolog="${logpath}/checkrepos.log"
	local searchresults="${logpath}/searchforupdates.log"
	local toupdate="${aurupdate}/outofdate.log"
	local package
	local available

	# aur-update does not come with a log directory. It will create one on first run
	echo "Checking setup"
	if [ ! -d "$logpath" ]; then
		mkdir "$logpath"
	fi

	# Each aur-update log will be preceeded by a date and time stamp
	# run checksetup and create log
	if [ -f "$setuplog" ]; then
		echo "" >> "$setuplog"
	fi
	echo $(date) >> "$setuplog"
	echo "" >> "$setuplog"
	checksetup 0>&1 | tee "$setuplog">&1

	echo "Check complete. You will find the log in ${logpath}."

	# Update list of foreign packages
	sudo pacman -Qm > aurpackages.log

	# run checkrepos and create log

	if [ -f "$repolog" ]; then
		echo "" >> "$repolog"
	fi
	echo $(date) >> "$repolog"
	echo "" >> "$repolog"
	checkrepos 0>&1 | tee "$repolog">&1
	local code=$?

	if [[ "$code" -eq 1 ]]; then
		echo "There was a repository that was non-existent. You will find the log in ${logpath}."
	else
		echo "Check successful. No errors discovered."
	fi

	# run searchforupdates and create log.
	echo "Checking for updates. This may take a while."
	if [ -f "$searchresults" ]; then
		echo "" >> "$searchresults"
	fi
	echo $(date) >> "$searchresults"
	echo "" >> "$searchresults"
	searchforupdates 0>&1 | tee "$searchresults"
	code=$?

	if [[ "$code" -eq 1 ]]; then
		echo "No match was found when searching through package list. You will find the log in ${logpath}."
	fi

	# If the list of packages to update exists and is not empty, then print list
	if [ -f "$toupdate" ] && [ -s "$toupdate" ]; then
		echo "The following packages have updates available"
		while IFS= read -r available; do
			echo "$available"
		done < "$toupdate"
	
		echo "If you wish to update, you will need to run the update script."
	
	else
		echo "All packages are up to date."
	fi

	return 0
}
