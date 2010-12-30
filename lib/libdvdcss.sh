Libdvdcss() {

	rpm -q libdvdcss
	if [[ "$?" == 0 ]] ; then

		OkMsg "Libdvdcss package is already installed"

	else
		
		yum --enablerepo=atrpms install libdvdcss -y

		[[ "$?" != 0 ]] && ErrMsg "Could not install package libdvdcss"

	fi

}
