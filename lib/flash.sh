Flash() {

	echo "[$FUNCNAME]"

	IsX86_64
	if [[ "$?" != 0 ]]; then

		rpm -q adobe-release-i386
	
		[[ "$?" != 0 ]] && \
			rpm -Uvh http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm

		[[ -f /etc/yum.repos.d/adobe-linux-i386.repo ]] && \
			sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/adobe-linux-i386.repo

		# yum update -y pulseaudio-libs.i386

		rpm -q flash-plugin

		[[ "$?" == 0 ]] && OkMsg "Flash plugin already installed" && return 0

		mkdir -p /usr/lib/mozilla/plugins

		yum install -y nspluginwrapper.{i586,x86_64} alsa-plugins-pulseaudio.i686

		yum --enablerepo=adobe-linux-i386 install -y flash-plugin
	
		if [[ "$?" == 0 ]]; then

			OkMsg "Flash plugin installed, RESTART Firefox"

		else

			ErrMsg "Could not install package flash-plugin" && return 1

		fi

	else

		yum install -y alsa-plugins-pulseaudio

		FLASHPKG='flashplayer_square_p2_64bit_linux_092710.tar.gz'

		cd ~
		rm -rf "$FLASHPKG"

		Download name "$FLASHPKG"

		mkdir -p /usr/lib64/mozilla/plugins
		tar -zxf "$FLASHPKG" --directory=/usr/lib64/mozilla/plugins

		if [[ "$?" == 0 ]]; then

			chown root:root /usr/lib64/mozilla/plugins/libflashplayer.so
			chmod 755 /usr/lib64/mozilla/plugins/libflashplayer.so
			
			if [[ -f /selinux/enforce ]]; then
			
			    restorecon /usr/lib64/mozilla/plugins/libflashplayer.so
			    
			 fi
			
			OkMsg "Flash plugin installed, RESTART Firefox"

		else

			ErrMsg "Could not install package flash-plugin" && return 1

		fi

		rm -rf "$FLASHPKG"

	fi

	# Prevent npviewer blocking by SELinux
	# [[ -f /selinux/enforce ]] && restorecon -R -v "$USERHOME"/.fontconfig

	mozilla-plugin-config -i -g > /dev/null

}

