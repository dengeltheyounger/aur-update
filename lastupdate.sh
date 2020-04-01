#!/bin/bash

lastupdate() {
	local packagelog="${aurupdate}/aurpackages.log"
	local result

	# Make sure that one argument was given

	if [[ "$#" -ne 1 ]]; then
		exit 1
	fi

	# Caller gives package name. result is set to first match

	if ! result=$(grep -m1 "$1" "$packagelog"); then
		exit 2
	fi

	# strip result to get date and echo

	result="${result#* }"

	echo "${result}"
	
	exit 0
}
