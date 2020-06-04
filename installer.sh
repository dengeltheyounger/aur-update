#!/bin/bash

path=$(pwd)

if [[ ! -d "${HOME}/bin" ]]; then
	echo "${HOME}/bin does not exist. Creating."
	mkdir "${HOME}/bin"
else
	echo "${HOME}/bin already exists. Moving on."
fi

currfile=$(basename "${0}")

if [[ -f "aurpackages.log" ]]; then
	rm "aurpackages.log"
fi

if [[ -f "${path}/aur-update" ]]; then
	rm "${path}/aur-update"
fi

echo "#!/bin/bash" >> "${path}/aur-update"

for file in *; do
	if [[ -f "${file}" ]] && [[ "${file}" != "${currfile}" ]]; then
		sed '\|#!/bin/bash|d' "${file}" | cat >> "${path}/aur-update"
	fi
done

chmod +x aur-update

mv "${path}/aur-update" "${HOME}/bin"

if ! $(grep -m1 "export PATH=\"${HOME}/bin:$PATH\"" ${HOME}/.bashrc); then
	echo "export PATH=\"${HOME}/bin:$PATH\"" >> "${HOME}/.bashrc"
else
	echo "${HOME}/bin already set in path!"
fi

exit 0
