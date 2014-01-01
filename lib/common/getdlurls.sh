GetDlUrls() {

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
	

	URLSFILE="el_dlurls.txt"

	cd ~
	rm -rf "$URLSFILE"
	wget "http://www.scientificlinuxbr.org/easylife/$URLSFILE"
	if [[ $? != 0 ]]; then
	
	#	wget "http://www.dulinux.com-a.googlepages.com/$URLSFILE"
	#	if [[ $? != 0 ]]; then
			
			ErrMsg "Could not get download urls. Aborting"
			return 1	

	#	fi

	fi


	#Save previous IFS
	PREVIOUS_IFS="$IFS"

	if [[ ! -e ~/"$URLSFILE" ]]; then

		ErrMsg "Download urls file does not exist"
		return 1

	fi

	#Populate arrays with package names and respective urls
	COUNT=0
	while IFS=';' read pkg url; do

		PKGS["$COUNT"]="$pkg"
		URLS["$COUNT"]="$url"
		let COUNT++

	done < ~/"$URLSFILE"

	#Restore previous IFS
	IFS=$PREVIOUS_IFS


	if [[ -z "${PKGS[*]}" ]]; then

		ErrMsg "PKGS array is empty"
		return 1
	
	fi

	return 0

}
