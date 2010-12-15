LivnaOn() {

	rpm -q livna-release > /dev/null

	if [[ $? != 0 ]]; then

		rpm -Uvh http://rpm.livna.org/livna-release.rpm
		if [[ $? != 0 ]]; then
		
			DisplayError "$GETOPT_MSG_TITLE" "$LIVNANEEDED_MSG_TXT"
			ErrMsg "Could not install Livna: libdvdcss won't be installed."
			return 1

		fi
		
	fi
	
	[[ -f /etc/yum.repos.d/livna.repo ]] && \
		# #Range: first line is the one with [livna] and the last with [livna-debuginfo]
		# sed -i "/\[livna\]/,/\[livna-debuginfo\]/s/enabled=0/enabled=1/g" /etc/yum.repos.d/livna.repo
		
		# Disable livna by default since we will use it just for libdvdcss
		sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/livna.repo

	return 0

}
