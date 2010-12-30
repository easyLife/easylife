DisplayRadioList() {

	unset SELECTION

	SELECTION=$(						\
		zenity --list					\
		--window-icon="/usr/share/pixmaps/easylife.png" \
		--title "$1" 					\
		--width="$2" --height="$3"			\
		--text "$4"					\
		--radiolist					\
		--column "$COMMON_MSG_PICKONE"			\
		--column "$5"					\
		$6 2> /dev/null					)

}
