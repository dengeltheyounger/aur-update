#!/bin/bash

getsiteversion() {
	local temp
	# Make sure that at least one argument was given
	if [[ "$#" -ne 1 ]]; then
		exit 1
	fi

	# Use wget to download html and store in temp. Curl can also be used
	wget -q -O temp  "https://aur.archlinux.org/packages/${1}"
	# curl -s "https://aur.archlinux.org/packages/$1" -o temp

	# Get the package version
	local siteupdate=$(sed -n -e "s/.*Package Details: ${1} //p" temp)
	# Remove html tag at end
	local siteupdate="${siteupdate%%<*}"
	rm temp

	echo "$siteupdate"

	exit 0
}

