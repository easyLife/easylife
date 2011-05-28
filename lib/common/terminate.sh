Terminate() {

	echo "[$FUNCNAME]"
	echo

	# Restore refresh-packagekit plugin config
	
	if [[ -f /etc/yum/pluginconf.d/refresh-packagekit.conf.el-backup ]]; then

		mv /etc/yum/pluginconf.d/refresh-packagekit.conf.el-backup /etc/yum/pluginconf.d/refresh-packagekit.conf

	fi

	# End program message
	DisplayInfo "$GETOPT_MSG_TITLE" "250" "250" "$ENDMSG_MSG_TEXT"

	# Kill background-running zenity notification icon
	#ZNI_PID=$(pgrep -f "zenity --notification --window-icon=/usr/share/pixmaps/easylife.png")

	[[ -n "$ZNI_PID" ]] && kill "$ZNI_PID"

	OkMsg "Terminating program..."	
	
	exit

}
