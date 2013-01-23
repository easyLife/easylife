DesktopLink() {

	echo "[$FUNCNAME]"


	[[ -d "$USERHOME/Desktop" ]] && OkMsg "Desktop link already exists" && return 0


	if [[ -f "$USERHOME/.config/user-dirs.dirs" ]]; then

		DESKFOLDER="$(cat $USERHOME/.config/user-dirs.dirs | grep -i XDG_DESKTOP_DIR)"
		DESKFOLDER="${DESKFOLDER##*/}"
		DESKFOLDER="${DESKFOLDER%\"}"
	
	else

		ErrMsg "Cannot find user-dirs.dirs file"
		return 1

	fi

	if [[ -n "$DESKFOLDER" ]]; then

		if [[ "$DESKFOLDER" = "Desktop" ]]; then
		
			OkMsg "Desktop folder is ok"
			return 0

		fi

		OkMsg "Desktop folder is [$USERHOME/$DESKFOLDER]"

		ln -s "$USERHOME/$DESKFOLDER" "$USERHOME/Desktop"
		[[ $? = 0 ]] &&	OkMsg "Desktop link created"

		return 0

	else

		ErrMsg "Could not create Desktop link"
		return 1

	fi

}
