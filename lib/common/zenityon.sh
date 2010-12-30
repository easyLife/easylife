ZenityOn() {

	rpm -q zenity > /dev/null
	if [[ "$?" != 0 ]]; then
		
		echo -e "\nInstalling zenity...\n"
		yum install -y zenity
		if [[ "$?" != 0 ]]; then

			ErrMsg "Could not install zenity"
			return 1
		
		elif [[ "$?" == 0 ]]; then

			OkMsg "zenity installed"
			return 0

		fi
	
	elif [[ "$?" == 0 ]]; then
	
		return 0

	fi

}
