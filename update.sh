	#!/bin/bash

update() {
	# paths to the necessary files
	local updatelog="${aurupdate}/aurpackages.log"
	local toupdate="${aurupdate}/outofdate.log"
	local siteversion="${aurupdate}/getsiteversion.sh"
	local aurlog="${aurpath}/log"
	local logname="$(date +%Y%m%d)"
	local logheader=$(date)
	local package

	# If outofdate.log doesn't exist, then exit
	if [ ! -f "${toupdate}" ]; then
		return 1
	fi

	cd "$aurpath"

	# Iterate through each package in outofdate.log and update. Send information to appropriate log
	while IFS= read -r package; do
		package="${package%% *}"
		local version=$("$siteversion" "$package")
		if [[ ! -n $(find . -type d -name "$package") ]]; then
			echo "Repository not found. Continuing."
			continue
		fi

		cd "$package"
		echo "Entering repository. I will need your permission to run makepkg."
		echo "Running git pull."
		git pull origin master
		echo "$logheader" >> "${aurlog}/${package}/${logname}.log"
		yes | makepkg -rsci | script -ca "${aurlog}/${package}/${logname}.log"
	
		local code="${PIPESTATUS[1]}"

		if [[ "$code" -gt 0 ]]; then
			echo "Error with makepkg. Continuing."
			continue
		fi

		cd "$aurpath"

		echo "Updating log for ${package}"
	
		sed -e "s/${package}.*$/${package} ${version}/" "$toupdate"

	done < "$toupdate"

	# Remove outofdate.log when finished
	rm "$toupdate"

	return 0
}
