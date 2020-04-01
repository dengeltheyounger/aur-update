#!/bin/bash

parser() {
	set -e
	set -u
	set -o pipefail

	if [[ "$#" -eq 0 ]]; then
		echo "aur-update usage: $(basename $0) [-C] [-M destination] [-U] [-v]"
		return 1
	fi

	checkupvar=0
	movereposvar=0
	movedest=
	upgradevar=0
	verbose=0

	while getopts 'CM:Uv' OPTION; do
		case "$OPTION" in
			C)
				checkupvar=1
			;;
			U)
				upgradevar=1
			;;
			M)
				movereposvar=1
				movedest="${OPTARG}"
			;;
			v)
				verbose=1
			;;
			*)
				echo "aur-update usage: $(basename $0) [-C] [-M destination] [-U] [-v]"
				return 1
			;;
		esac
	done
	shift $(( $OPTIND-1 ))

	if [[ "$movereposvar" -eq 1 ]]; then
		moverepos "${movedest}"
	fi

	if [[ "$checkupvar" -eq 1 ]]; then
		checkup 0>&1
	fi

	if [[ "$upgradevar" -eq 1 ]]; then
		update 0>&1
	fi

	code=$?

	if [[ "$code" -eq 1 ]]; then
		return 2
	fi

	return 0
}
