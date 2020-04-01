#!/bin/bash

moverepos() {

	if [[ "$#" -ne 1 ]]; then
		exit 1
	fi

	# Sudo is used in case the directory into which the directory is moved is
	# owned by root or another user. For example, /usr/src/AUR -> /usr/local/src/AUR
	sudo mv "$aurpath" "$1"
	sudo chown "$USER" "$1"
	local newpath="$1"

	sed -i "s:aurpath=.*:aurpath=${newpath}:" ~/.aurconfig

	exit 0
}
