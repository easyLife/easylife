Download() {

	[[ -z "${PKGS[*]}" ]] && return 1

	for KEY in "${!PKGS[@]}"; do

		[[ "${PKGS[KEY]}" == *"$2"* ]] && break;

	done

	[[ -z "${URLS[*]}" ]] && return 1


	if   [[ "$1" == "noname" ]]; then
	
		wget --output-document="${PKGS[KEY]}" "${URLS[KEY]}"

		if [[ "$?" == 0 ]]; then

			return 0

		else

			return 1

		fi


	elif [[ "$1" == "name" ]]; then

		wget --output-document="${PKGS[KEY]}" "${URLS[KEY]}${PKGS[KEY]}"

		if [[ "$?" == 0 ]]; then

			return 0

		else

			return 1

		fi
	
	fi

}
