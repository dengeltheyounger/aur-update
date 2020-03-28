#!/bin/bash

aurpath="/usr/src/AUR"
createdpath=0

echo "Checking for update log directory"

if [ ! -d updatelogs ]; then
	echo "Log directory missing. Creating"
	mkdir updatelogs
fi

echo "Checking AUR path" 

# If aur path does not exist, create it and give it change the ownership to local user

if [ ! -d "$aurpath" ]; then
	createdpath=1
	echo "Creating directory $aurpath."
	sudo mkdir "$aurpath"
	sudo chown "$USER" "$aurpath"
	echo "$USER now owns $aurpath."
fi

echo "Checking repository log directory" 

if [ ! -d "$aurpath"/log ]; then
	echo "Repository log directory does not exist. Creating"
	mkdir "$aurpath"/log
fi

# If aur directory had to be created, then move update into the directory. 
# consider changing this.

if [[ "$createdpath" -eq 1 ]]; then
	echo "Moving myself to $aurpath."
	mv $(pwd) "$aurpath"
fi

echo "Setup complete. Exiting"

exit 0
