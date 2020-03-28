#!/bin/bash

aurpath="/usr/src/AUR"
createdpath=0

echo "Checking AUR path" 

# If aur path does not exist, create it and give it change the ownership to local user

if [ ! -d "$aurpath" ]; then
	createdpath=1
	echo "Creating directory $aurpath."
	sudo mkdir "$aurpath"
	sudo chown "$USER" "$aurpath"
	echo "$USER now owns $aurpath."
fi

# move to aur path and then check log directory. Create if it does not exist
cd "$aurpath"

echo "Checking log directory" 

if [ ! -d "log" ]; then
	echo "Creating log directory"
	mkdir log
fi

# If aur directory had to be created, then move update into the directory. 
# consider changing this.

if [[ "$createdpath" -eq 1 ]]; then
	echo "Moving myself to $aurpath."
	mv path=$(pwd) "$aurpath"
fi

echo "Setup complete. Exiting"

exit 0
