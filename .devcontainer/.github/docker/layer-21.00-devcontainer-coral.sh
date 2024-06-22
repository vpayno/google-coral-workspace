#!/bin/bash
#
# .github/docker/layer-21.00-devcontainer-coral.sh
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

	echo Running: /.github/citools/coral/coral-setup-install
	time /.github/citools/coral/coral-setup-install || track_errors
	printf "\n"

	echo Running: /.github/citools/coral/coral-setup-config
	time /.github/citools/coral/coral-setup-config || track_errors
	printf "\n"

	echo Adding source /etc/profile.d/coral.sh to ~/.bashrc and /etc/skel/.bashrc
	echo '. /etc/profile.d/coral.sh' | tee -a "${HOME}/.bashrc" | tee -a "${HOME}/.profile" | tee -a /etc/skel/.bashrc || track_errors
	printf "\n"

	echo Running: source /etc/profile.d/coral.sh
	# shellcheck disable=SC1091
	source /etc/profile.d/coral.sh || track_errors
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

time main "${@}" |& tee "${HOME}"/layer-21.00-devcontainer-coral.log
