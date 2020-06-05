#!/bin/bash

searchforupdates() {
	# Paths to the appropriate files
	local packagelist="${aurupdate}/aurpackages.log"
	local outofdate="${aurupdate}/outofdate.log"
	local haderror=0
	local package

	echo "Checking for updates."

	# Iterate through each package repository.
	while IFS= read -r package; do
		package="${package%% *}"
		echo "Package ${package}: checking for user's last update."

		# Check user's package version
		local userupdate=$(lastupdate "$package")
		local code=$?

		echo "Latest version for user: ${userupdate}."

		local siteupdate=$(getsiteversion "$package")
		echo "Latest version on site: ${siteupdate}."
	
		if [[ "$code" -eq 2 ]]; then
			echo "No update information found for ${package}. Error."
			haderror=1
	
		# Check user's package version with the site. If an update is availabe, create log
		else 	
			if [ $(vercmp "$siteupdate" "$userupdate") -gt 0 ]; then
				echo "An update is available for you to review."
				echo "$package" >> "$outofdate"
			else
				echo "${package} is up to date"
			fi
		fi

	done < "$packagelist"

	if [[ "$haderror" -eq 1 ]]; then
		return 1
	fi

	return 0
}
