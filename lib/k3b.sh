K3b() {
	echo "[$FUNCNAME]"
	dnf install -y --disableplugin=refresh-packagekit k3b k3b-extras-freeworld lame lame-mp3x libmad
	
	if [[ "$?" != 0 ]]; then
        ErrMsg "Could not install packages"
        return 1
    fi

	#chmod ug+s /usr/bin/cdrdao /usr/bin/cdrecord -v
	#[[ $? != 0 ]] && ErrMsg "Could not set file attributes" && return 1
}
