Thunderbird() {

	echo "[$FUNCNAME]"

	yum install -y thunderbird

	if [[ "$?" == 0 ]]; then

		sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /desktop/gnome/url-handlers/mailto/command "thunderbird %s"

	else

		ErrMsg "Could not install package"

	fi

}
