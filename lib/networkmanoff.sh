NetworkManOff() {

	echo "[$FUNCNAME]"

	IsGnome
	[[ $? != 0 ]] && ErrMsg "Not Gnome running" && return 1

	/sbin/service network stop
	/sbin/service NetworkManager stop
	/sbin/chkconfig NetworkManager off --level 5

	sleep 8

	/sbin/service network start
	/sbin/chkconfig network on --level 5

	[[ $? = 0 ]] && echo -e "\n\tRemember to RESTART Firefox\n"

}

