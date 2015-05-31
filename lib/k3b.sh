K3b() {
	echo "[$FUNCNAME]"
	dnf install -y --disableplugin=refresh-packagekit k3b k3b-extras-freeworld normalize transcode vcdimager lame lame-mp3x libmad
	
	[[ $? != 0 ]] && ErrMsg "Could not install packages" && return 1

	#chmod ug+s /usr/bin/cdrdao /usr/bin/cdrecord -v
	#[[ $? != 0 ]] && ErrMsg "Could not set file attributes" && return 1
}
