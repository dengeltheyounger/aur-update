#!/bin/bash

# paths to the necessary files
aurupdate=$(pwd)
updatelog="${aurupdate}/aurpackages.log"
toupdate="${aurupdate}/outofdate.log"
siteversion="${aurupdate}/getsiteversion.sh"
aurrepos="/usr/src/AUR"
aurlog="${aurrepos}/log"
logname="$(date +%Y%m%d)" 

# If outofdate.log doesn't exist, then exit
if [ ! -f "${toupdate}" ]; then
	exit 0
fi

cd "$aurrepos"

# Iterate through each package in outofdate.log and update. Send information to appropriate log
while IFS= read -r package; do
	package="${package%% *}"
	version=$(./"$siteversion" "$package")
	if [[ ! -n $(find . -type d -name "$package") ]]; then
		echo "Repository not found. Continuing."
		continue
	fi

	cd "$package"

	echo "Entering repository. I will need your permission to run makepkg."

	yes | makepkg -rsci | tee > "${aurlog}/${package}/${logname}"
	
	code="${PIPESTATUS[1]}"

	if [[ "$code" -gt 0 ]]; then
		echo "Error with makepkg. Continuing."
		continue
	fi

	cd "$aurrepos"

	echo "Updating log for ${package}"
	
	sed -e "s/${package}.*$/${package} ${version}/" "$toupdate"

done < "$toupdate"

# Remove outofdate.log when finished
rm "$toupdate"

exit 0
