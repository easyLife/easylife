SetupKeyboard() {

	echo "[$FUNCNAME]"

	sudo -u "$USERNAME" "$DSBA" gconftool-2 -s -t \
			int /desktop/gnome/peripherals/keyboard/rate 50

	[[ $? = 0 ]] && OkMsg "Keyboard rate set"

				
	sudo -u "$USERNAME" "$DSBA" gconftool-2 -s -t \
			int /desktop/gnome/peripherals/keyboard/delay 250

	[[ $? = 0 ]] && OkMsg "Keyboard delay set"

}
