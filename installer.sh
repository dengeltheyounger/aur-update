#!/bin/bash

path=$(pwd)

chmod +x *.sh

# Check to see if /home/bin exists. Create if not

if [[ ! -d "${HOME}/bin" ]]; then
	echo "${HOME}/bin does not exist. Creating."
	mkdir "${HOME}/bin"
else
	echo "${HOME}/bin already exists. Moving on."
fi

currfile=$(basename "${0}")

# Remove aurpackages.log if necessary

if [[ -f "aurpackages.log" ]]; then
	rm "aurpackages.log"
fi

# Check to see if aur-update script exists in the directory. Create if not

if [[ -f "${path}/aur-update" ]]; then
	rm "${path}/aur-update"
fi

# Add the shebang into the aur-update script

echo "#!/bin/bash" >> "${path}/aur-update"

cat "${path}/setaurconfig.sh" >> "${path}/aur-update"

# For each sh file, remove the shebang and add to aur-update script

for file in *.sh; do
	if [[ "${file}" != "uninstaller.sh" ]] && [[ "${file}" != "${currfile}" ]]; then
		# skip aur-update.sh, this needs to be last
		if [[ "${file}" == "aur-update.sh" ]]; then
			continue
		else
			sed '\|#!/bin/bash|d' "${file}" | cat >> "${path}/aur-update"
		fi
	fi
done

sed '\|#!/bin/bash|d' "${path}/aur-update.sh" | cat >> "${path}/aur-update"

# Make aur-update script executable

chmod +x aur-update

# Move the aur-update script into bin

mv "${path}/aur-update" "${HOME}/bin"

# Add an export home/bin to path into .bashrc (if it's not there already)

if ! $(grep -m1 "export PATH=\"${HOME}/bin:$PATH\"" ${HOME}/.bashrc); then
	echo "export PATH=\"${HOME}/bin:$PATH\"" >> "${HOME}/.bashrc"
else
	echo "${HOME}/bin already set in path!"
fi

exit 0
