IsGnome() {

	pgrep -f "gnome-session" > /dev/null

	if [[ $? = 0 ]]; then

		OkMsg "Gnome is running"
		return 0

	else

		ErrMsg "Gnome is not running"
		return 1

	fi

}
