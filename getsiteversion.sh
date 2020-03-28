#!/bin/bash

if [[ "$#" -ne 1 ]]; then
	exit 1
fi

wget -q -O temp  "https://aur.archlinux.org/packages/$1"
# curl -s "https://aur.archlinux.org/packages/$1" -o temp
siteupdate=$(sed -n -e "s/.*Package Details: $1 //p" temp)
siteupdate="${siteupdate%%<*}"
rm temp

echo "$siteupdate"
exit 0
