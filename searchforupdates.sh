#!/bin/bash

# Paths to the appropriate files
aurupdate=$(pwd)
packagelist="${aurupdate}/aurpackages.log"
updatechecker="${aurupdate}/lastupdate.sh"
siteversion="${aurupdate}/getsiteversion.sh"
outofdate="${aurupdate}/outofdate.log"
aurrepos="/usr/src/AUR"
haderror=0

echo "Checking for updates."

# Iterate through each package repository.
while IFS= read -r package; do
	package="${package%% *}"
	echo "Package $package: checking for last update."

	# Check the site's package version
	siteupdate=$(sh "$siteversion" "$package") 
	
	echo "Success. Latest version on site: $siteupdate."

	# Check user's package version
	userupdate=$(sh "$updatechecker" "$package")
	code=$?

	echo "Latest version for user: ${userupdate}."
	
	if [[ "$code" -eq 2 ]]; then
		echo "No update information found for ${package}. Error."
		haderror=1
	
	# Check user's package version with the site. If an update is availabe, create log
	else 	
		if [ $(vercmp "$siteupdate" "$userupdate") -gt 0 ]; then
			echo "An update is available for you to review."
			echo "$package" >> "$outofdate"
		else
			echo "$package is up to date"
		fi
	fi

done < "$packagelist"

if [[ "$haderror" -eq 1 ]]; then
	exit 1
fi

exit 0
