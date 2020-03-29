#!/bin/bash
source ~/.aurconfig

# This allows some independence of where the aur-update program is, as well as where the
# AUR repos are. 
packagelist="$(pwd)/aurpackages.log"
repologsdir="${aurrepos}/log"
haderror=0

cd "$aurrepos"

echo "Checking repositories. Will create them if they do not exist"

# Iterate through package names and see if there's a corresponding directory.
while IFS= read -r package; do
	package="${package%% *}"
	
	if [ -d "$package" ]; then
		echo "Repository exists. Moving on."
	else
		# If there is not, run git clone using the package name
		
		# There should be a way to handle cases where the repository is empty
		echo "Repository ${package} does not exist. Creating a new one."
		status=$(git clone https://aur.archlinux.org/"$package".git 2>&1>&0)
		code=$?
		
		# If code is not zero, set haderror accordingly
		if [[ "$code" -eq 128 ]]; then
			echo "The repository does not exist. Error."
			haderror=1
			continue
		fi
	fi

	# Create a corresponding log directory if it does not exist
	if [ ! -d "${repologsdir}/${package}" ]; then 
		echo "Making a log directory for repository $package"
		mkdir "${repologsdir}/${package}"
	fi

done < "$packagelist"

# exit status will be the same value as haderror
if [[ "$haderror" -eq 1 ]]; then
	exit 1
fi

exit 0
