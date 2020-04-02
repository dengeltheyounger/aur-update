#!/bin/bash

lastupdate() {
	# Make sure that one argument was given
	if [[ "$#" -ne 1 ]]; then
		return 1
	fi

	local pathtopkg="${aurpath}/$1/PKGBUILD"
	local version

	# Caller gives package name. result is set to first match

	if ! version=$(grep -m1 "pkgver" "$pathtopkg"); then
		return 2
	fi
	
	# Strip result to get version and echo
	# literally one package maintainer decided to put quotes around the
	#  version number. For that reason, I use tr
	version=$(echo "$version" | tr -d '"')
	echo "${version#*=}"
	
	return 0
}
