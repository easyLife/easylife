SsLockOff() {

	echo "[$FUNCNAME]"

	IsGnome
	[[ "$?" != 0 ]] && ErrMsg "Not Gnome running" && return 1


	sudo -u "$USERNAME" "$DSBA" gconftool-2 -s -t bool /apps/gnome-screensaver/lock_enabled false

	if [[ "$?" != 0 ]]; then

		ErrMsg "Could not turn screensaver lock off"
		return 1

	elif [[ "$?" = 0 ]]; then

		OkMsg "Lock_enabled set"
		return 0
	
	fi

}
