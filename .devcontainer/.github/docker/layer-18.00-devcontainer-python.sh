#!/bin/bash
#
# .github/docker/layer-18.00-devcontainer-python.sh
#

set -o pipefail

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

# shellcheck disable=SC1091
source /.github/citools/includes/wrapper-library || exit

main() {
	declare -i retval=0

	layer_begin "${0}" "$@"

	echo Running: /.github/citools/python/python-setup-install
	time /.github/citools/python/python-setup-install || track_errors
	printf "\n"

	echo Running: /.github/citools/python/python-setup-config
	time /.github/citools/python/python-setup-config || track_errors
	printf "\n"

	echo Adding source /etc/profile.d/python.sh to ~/.bashrc and /etc/skel/.bashrc
	echo '. /etc/profile.d/python.sh' | tee -a "${HOME}/.bashrc" | tee -a "${HOME}/.profile" | tee -a /etc/skel/.bashrc || track_errors
	printf "\n"

	echo Running: source /etc/profile.d/python.sh
	# shellcheck disable=SC1091
	source /etc/profile.d/python.sh || track_errors
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

time main "${@}" |& tee "${HOME}"/layer-18.00-devcontainer-python.log
