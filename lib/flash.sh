Flash() {

	echo "[$FUNCNAME]"

	rpm -q flash-plugin

	[[ "$?" == 0 ]] && OkMsg "Flash plugin already installed" && return 0

	IsX86_64
	if [[ "$?" == 0 ]]; then

		rpm -q adobe-release-x86_64
		[[ "$?" != 0 ]] && \
			rpm -Uvh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm

		yum install -y --disableplugin=refresh-packagekit flash-plugin
	
		if [[ "$?" == 0 ]]; then

			OkMsg "Flash plugin installed, RESTART Firefox"

		else

			ErrMsg "Could not install package flash-plugin" && return 1

		fi

	else

		rpm -q adobe-release-i386
		[[ "$?" != 0 ]] && \
			rpm -Uvh http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm

		yum install -y --disableplugin=refresh-packagekit nspluginwrapper alsa-plugins-pulseaudio flash-plugin

		if [[ "$?" == 0 ]]; then
	
			OkMsg "Flash plugin installed, RESTART Firefox"

		else

			ErrMsg "Could not install package flash-plugin" && return 1

		fi

	fi


	#if [[ -f /selinux/enforce ]]; then
			
	#	restorecon /usr/lib64/mozilla/plugins/libflashplayer.so
			    
	#fi

}
