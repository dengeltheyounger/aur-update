#!/bin/bash

checksetup() {
	# This will allow the user to more easily change where the aur-update logs are found. 
	local updatelogpath="${aurupdate}/updatelogs"
	local aurlogs="${aurpath}/log"

	echo "Checking for update log directory."

	# If the updatelogs directory does not exist, create it.
	if [ ! -d "$updatelogpath" ]; then
		# Generally this isn't necessary. But I don't know where the user will put their logs.
		# They can amend this as needed
		echo "Log directory missing. Creating"
		sudo mkdir "$updatelogpath"
		sudo chown "$USER" "$updatelogpath"
	else
		echo "Found update log directory."
	fi

	echo "Checking AUR path" 

	# If aur path does not exist, create it and give it change the ownership to local user
	if [ ! -d "$aurpath" ]; then
		echo "Creating directory $aurpath."
		sudo mkdir "$aurpath"
		sudo chown "$USER" "$aurpath"
		echo "${USER} now owns ${aurpath}."
	else
		echo "AUR path found."
	fi

	echo "Checking repository log directory" 

	# If within the aurpath there is no log directory for the repositories, create one.
	if [ ! -d "$aurlogs" ]; then
		echo "Repository log directory does not exist. Creating"
		mkdir "$aurlogs"
	else
		echo "Repository log directory found."
	fi

	echo "Setup complete. Exiting"

	exit 0
}
