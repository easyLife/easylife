WhichUser() {

	echo "[$FUNCNAME]"

	if [[ ! -e /etc/passwd ]]; then

		ErrMsg "/etc/passwd missing!"
		return 1

	fi

	#Save previous IFS
	PREVIOUS_IFS=$IFS

	#Populate arrays with regular users name and respective homes
	COUNT=0
	unset USERS
	unset HOMES
	while IFS=':' read user pass uid gid gecos home shell; do

		if [[ "$uid" -gt 499 && "$uid" -lt 65534 ]]; then

			USERS[$COUNT]="FALSE $user"
			HOMES[$COUNT]="$home"
			let COUNT++

		fi

	done < /etc/passwd
	
	#Restore previous IFS
	IFS=$PREVIOUS_IFS

	#Display error if there is no regular user in the system and exit function
	if [[ -z "${USERS[*]}" ]]; then

		DisplayError "$COMMON_MSG_ERROR" "$WHICHUSER_MSG_NOREGULARUSER"
		return 1

	#If only one regular user, select it
	elif [[ "${#USERS[*]}" -eq "1" ]]; then

		SELECTION="${USERS[0]#'FALSE '}"


	#If more than one regular user, let the person choose which one should be used
	else

		DisplayRadioList			\
			"$WHICHUSER_MSG_TITLE"		\
			"$WHICHUSER_MSG_WIDTH"		\
			"$WHICHUSER_MSG_HEIGHT"		\
			"$WHICHUSER_MSG_TEXT"		\
			"$WHICHUSER_MSG_USERCOLUMN"	\
			"${USERS[*]}"

		if [[ -z "$SELECTION" || "$SELECTION" == "" ]]; then
			
			return 1
		
		fi

	fi


	if [[ -z "$SELECTION" || "$SELECTION" == "" ]]; then

		return 1

	fi

	USERNAME="$SELECTION"

	#Loop USERS array in order to find the selected user's array-key
	for USERKEY in "${!USERS[@]}"; do

		[[ "${USERS[USERKEY]}" == *"$SELECTION"* ]] && break;

	done

	if [[ -z "${HOMES[$USERKEY]}" ]]; then

		return 1

	fi

	USERHOME="${HOMES[$USERKEY]}"

	OkMsg "Selected user is $USERNAME @ $USERHOME"

	# Let's find out and store the user's DBUS_SESSION_BUS_ADDRESS variable so gconftool-2 work propoerly
	GSPID=$(pgrep -u "$USERNAME" -n gnome-session)
	DSBA=$(strings /proc/"$GSPID"/environ | grep DBUS_SESSION_BUS_ADDRESS)
	
	return 0

}
