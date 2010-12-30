IsX86_64() {

	if [[ "$(uname -m)" == "x86_64" ]]; then
	
		return 0

	fi

	return 1

}

