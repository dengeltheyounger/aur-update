#!/bin/bash
source setaurconfig.sh
source ~/.aurconfig
source checkrepos.sh
source checksetup.sh
source checkup.sh
source getsiteversion.sh
source lastupdate.sh
source moverepos.sh
source searchforupdates.sh
source update.sh
source parser.sh

parser "$@"
code=$?

if [[ "$code" -eq 1 ]]; then
	exit 1

elif [[ "$code" -eq 0 ]]; then
	exit 0
fi

exit 0
