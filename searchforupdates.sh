#!/bin/bash

cd ..
packagelist="aur-update/aurpackages.log"
updatechecker="lastupdate.sh"
siteversion="aur-update/getsiteversion.sh"
outofdate="aur-update/outofdate.log"
haderror=0

echo "Checking for updates."

while IFS= read -r package; do
	package="${package%% *}"
	echo "Package $package: checking for last update."
	siteupdate=$(./"$siteversion" "$package") 
	
	echo "Success. Latest version on site: $siteupdate."

	cd aur-update
	userupdate=$(./"$updatechecker" "$package")
	code=$?
	cd ..

	echo "Latest version for user: $userupdate."
	
	if [[ "$code" -eq 2 ]]; then
		echo "No update information found for $package. Error."
		haderror=1
	
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
