Libdvdcss() {
	rpm -q libdvdcss
	if [[ "$?" == 0 ]] ; then
		OkMsg "Libdvdcss package is already installed"
	else
		RemiOn 
		#dnf install -y --enablerepo=atrpms --disableplugin=refresh-packagekit libdvdcss
                dnf install -y --enablerepo=remi --disableplugin=refresh-packagekit libdvdcss
		[[ "$?" != 0 ]] && ErrMsg "Could not install package libdvdcss"
	fi
}
