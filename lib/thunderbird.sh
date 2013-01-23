Thunderbird() {

	echo "[$FUNCNAME]"

	yum install -y --disableplugin=refresh-packagekit thunderbird

	if [[ "$?" == 0 ]]; then

		# Did not find any gsettings correspondent schema
		#sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
		#	--set /desktop/gnome/url-handlers/mailto/command "thunderbird %s"
		echo

	else

		ErrMsg "Could not install package"

	fi

}
