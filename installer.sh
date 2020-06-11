#!/bin/bash

path=$(pwd)

# Check to see if /home/bin exists. Create if not

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

sudo mv "${path}/aur-update" "/usr/bin"

exit 0
