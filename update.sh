#!/bin/bash

updatelog="update/aurpackages.log"
toupdate="update/outofdate.log"
siteversion="update/getsiteversion.sh"
logname="$(date +%Y%m%d)" 

if [ ! -f "outofdate.log" ]; then
	exit 0
fi

cd ..

while IFS= read -r package; do
	package="${package%% *}"
	version=$(./"$siteversion" "$package")
	if [[ ! -n $(find . -type d -name "$package") ]]; then
		echo "Repository not found. Continuing."
		continue
	fi

	cd "$package"

	echo "Entering repository. I will need your permission to run makepkg."

	yes | makepkg -rsci | tee > ../log/$package/"$logname"
	
	code="${PIPESTATUS[1]}"

	if [[ "$code" -gt 0 ]]; then
		echo "Error with makepkg. Continuing."
		continue
	fi

	cd ..

	echo "Updating log for $package"
	
	sed -e "s/${package}.*$/${package} ${version}/" "$toupdate"

done < "$toupdate"

rm "$toupdate"

exit 0
