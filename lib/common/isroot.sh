IsRoot() {

	if [[ "$(whoami)" = "root" ]]; then

		return 0

	else

		DisplayError "$COMMON_MSG_ERROR" "$ISROOT_MSG_NEEDROOTPRIV"
		return 1
		
       	fi

}


