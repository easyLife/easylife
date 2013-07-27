RpmfusionOn() {

	echo "[$FUNCNAME]"

	rpm -q wget > /dev/null
	if [[ "$?" != 0 ]]; then
		
		echo -e "\nInstalling wget...\n"
		yum install -y wget
		if [[ "$?" != 0 ]]; then

			ErrMsg "Could not install wget"
			return 1
		
		elif [[ "$?" == 0 ]]; then

			OkMsg "wget installed"

		fi
	
	fi


	for i in 'free' 'nonfree'; do
	
		# Download stable or rawhide?
		VERSION='19'
		#VERSION='rawhide'

		rpm -q rpmfusion-"$i"-release > /dev/null
		if [[ "$?" != 0 ]]; then

			yum install -y --nogpgcheck --disableplugin=refresh-packagekit    \
                            http://download1.rpmfusion.org/"$i"/fedora/rpmfusion-"$i"-release-"$VERSION".noarch.rpm
			if [[ "$?" != 0 ]]; then
		
				DisplayError "$GETOPT_MSG_TITLE" "$RPMFUSIONNEEDED_MSG_TXT"
				ErrMsg "Could not install RPM Fusion repo $i $VERSION"

				return 1

			fi
		
		else
	
			OkMsg "RPM Fusion $i already installed"
			return 0

		fi


	done
	

	return 0

}

