Utils() {

	echo "[$FUNCNAME]"

	yum install -y --disableplugin=refresh-packagekit                                       \
                       nautilus-open-terminal system-config-boot system-config-language		\
		       dconf-editor gnome-tweak-tool cups-pdf p7zip p7zip-plugins	        \
		       unrar isomaster yumex xchm lshw lshw-gui					\
		       yum-presto yum-fastestmirror autojump
	
	if [[ "$?" != 0 ]]; then

		ErrMsg "Could not install packages"
		return 1
	
	fi

}
