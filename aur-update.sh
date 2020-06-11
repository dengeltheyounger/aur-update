#!/bin/bash

echo "${0}"

if [[ "$0" == "./aur-update.sh" ]]; then
	echo "Check succeeded"
	source setaurconfig.sh
	source checkrepos.sh
	source checksetup.sh
	source checkup.sh
	source getsiteversion.sh
	source lastupdate.sh
	source moverepos.sh
	source searchforupdates.sh
	source update.sh
	source parser.sh
else
	echo "Check failed"
fi

setaurconfig

source /home/"${USER}"/.aurconfig

parser "$@"
code=$?

if [[ "$code" -eq 1 ]]; then
	exit 1

elif [[ "$code" -ne 0 ]]; then
	exit 2
fi

path=$(pwd)

if [[ -f "${path}/aurpackages.log" ]]; then
	echo "Removing aurpackages.log"
	rm "${path}/aurpackages.log"
else
	echo "aurpackages.log does not appear to exist"
fi

exit 0
