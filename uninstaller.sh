#!/bin/bash

if [[ -f ~/.aurconfig ]]; then
	source ~/.aurconfig
fi

path=$(pwd)

echo "Checking to see if aurpackages.log exists."

if [[ -f "${path}/aurpackages.log" ]]; then
	echo "Removing aurpackages.log"
	rm "${path}/aurpackages.log"
else
	echo "aurpackages.log is not in directory. Moving on."
fi

echo "Checking to see if aur-update is in ${HOME}/bin."

if [[ -f "/usr/bin/aur-update" ]]; then
	echo "Removing aur-update. Will need a password."
	sudo rm "/usr/bin/aur-update"
else
	echo "aur-update not found. Moving on."
fi

echo "Checking for AUR directory"

if [[ -d "${aurpath}" ]]; then
	echo "Removing AUR directory"
	sudo rm -r "${aurpath}"
else
	echo "AUR directory not found. Moving on."
fi

echo "Checking for .aurconfig"

if [[ -f "${HOME}/.aurconfig" ]]; then
	echo "Removing .aurconfig"
else
	echo ".aurconfig not found. Moving on."
fi

echo "Checking for the update logs"

if [[ -d "${path}/updatelogs" ]]; then
	echo "Removing update logs"
	rm -r "${path}/updatelogs"
else
	echo "updatelogs not found."
fi

echo "Making all .sh files non executable. Installer and uninstaller will not be affected."

# This would be much faster using regex and find. I'm not familiar with regex however.

for file in *.sh; do
	if [[ "${file}" != "uninstaller.sh" ]] && [[ "${file}" != "installer.sh" ]]; then
		chmod -x "${file}"
	fi
done
