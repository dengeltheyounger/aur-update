#!/bin/bash

# This can be changed by the user as needed. Other scripts will need to be informed
aurpath="/usr/src/AUR"
# This will allow the user to more easily change where the aur-update logs are found. 
updatelogpath="$(pwd)/updatelogs"
aurlogs="${aurpath}/log"
createdpath=0

echo "Checking for update log directory"

# If the updatelogs directory does not exist, create it.
if [ ! -d "$updatelogpath" ]; then
	# Generally this isn't necessary. But I don't know where the user will put their logs.
	# They can amend this as needed
	echo "Log directory missing. Creating"
	sudo mkdir "$updatelogpath"
	sudo chown "$USER" "$updatelogpath"
fi

echo "Checking AUR path" 

# If aur path does not exist, create it and give it change the ownership to local user
if [ ! -d "$aurpath" ]; then
	createdpath=1
	echo "Creating directory $aurpath."
	sudo mkdir "$aurpath"
	sudo chown "$USER" "$aurpath"
	echo "${USER} now owns ${aurpath}."
fi

echo "Checking repository log directory" 

# If within the aurpath there is no log directory for the repositories, create one.
if [ ! -d "$aurlogs" ]; then
	echo "Repository log directory does not exist. Creating"
	mkdir "$aurlogs"
fi

# If aur directory had to be created, then move update into the directory. 
# consider changing this.
if [[ "$createdpath" -eq 1 ]]; then
	echo "Moving myself to $aurpath."
	mv $(pwd) "$aurpath"
fi

echo "Setup complete. Exiting"

exit 0
