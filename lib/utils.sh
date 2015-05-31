Utils() {
	echo "[$FUNCNAME]"

	dnf install -y --disableplugin=refresh-packagekit                                       \
                       nautilus-open-terminal system-config-boot system-config-language		\
		       dconf-editor gnome-tweak-tool cups-pdf p7zip p7zip-plugins	        \
		       unrar isomaster xchm lshw lshw-gui autojump
	
	if [[ "$?" != 0 ]]; then
		ErrMsg "Could not install packages"
		return 1
	fi
}
