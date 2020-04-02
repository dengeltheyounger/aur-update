#!/bin/bash

aurpath=/usr/local/src/AUR

getsiteversion() {
	# Make sure that at least one argument was given
	if [[ "$#" -ne 1 ]]; then
		return 1
	fi

	# Update git repo and check package build

	local pathtopkg="${aurpath}/$1/PKGBUILD"
	local version
	
	gitoutput=$(git pull)

	if ! version=$(grep -m1 "pkgver" "$pathtopkg"); then
		return 2
	fi

	# strip result to get version and echo
	# Literally one package build decided to put quotes around their
	# version number. For that reason, I include the if statement
		
	version=$(echo "$version" | tr -d '"')
	echo "${version#*=}"

	return 0
}

getsiteversion $1
