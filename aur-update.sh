#!/bin/bash

if [[ "$0" == "aurupdate.sh" ]]; then
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
fi

source ~/.aurconfig

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
