GoogleApps() {

	echo "[$FUNCNAME]"

	GoogleRepo
	if [[ "$?" != 0 ]]; then

		ErrMsg "Could not install Google Repo"
		return 1

	fi

	# Install google desktop and chrome
	yum install -y google-chrome-stable google-desktop-linux
	
	if [[ "$?" != 0 ]]; then

		ErrMsg "Could not install packages Chrome and Google Desktop"
		return 1
	
	fi


	# Install picasa 3 (testing) because the previous did not work with F12
	# Temp disabled: http://groups.google.com/group/google-labs-picasa-for-linux/browse_thread/thread/3e82926ac930bd3c
	echo -e "\n Picasa will not be installed due to bugs."
	echo -e "See: http://groups.google.com/group/google-labs-picasa-for-linux/browse_thread/thread/3e82926ac930bd3c"
	echo -e "\n"
<<COMMENTS
	yum install -y --enablerepo=google-testing picasa wine openssh openssl.i686

	if [[ "$?" != 0 ]]; then

		ErrMsg "Could not install picasa"
		return 1	

	else

		# Fix for authentication issue: "httpSendRequestEx failed (12157)"
		# The initial \ is to ignore the cp alias (which forces the -i interactive mode)
		\cp /usr/lib/wine/wininet.dll.so /opt/google/picasa/3.0/wine/lib/wine

		# Fix for SELinux
		/usr/sbin/setsebool -P mmap_low_allowed 1

	fi
COMMENTS

	OkMsg "Packages installed"
	return 0

}
