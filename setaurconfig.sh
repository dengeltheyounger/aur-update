#!/bin/bash

setaurconfig() {
	if [ ! -f ~/.aurconfig ]; then
		echo "aurpath=\"/usr/local/src/AUR\"" > ~/.aurconfig
		echo "aurupdate=\"/home/${USER}/aur-update\"" >> ~/.aurconfig
	fi
}
