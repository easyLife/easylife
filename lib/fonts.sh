Fonts() {
	echo "[$FUNCNAME]"

	dnf install -y --disableplugin=refresh-packagekit wget          \
                aajohan-*fonts adf-*fonts aldusleaf-*fonts		\
		allgeyer-*fonts apa-new-*fonts apanov-*fonts		\
		artwiz-*fonts beteckna-*fonts bitstream-*fonts		\
		bpg-*fonts dejavu-*fonts dustin-*fonts ecolier-*fonts	\
		gargi-*fonts gdouros-*fonts gfs-*fonts gnu-free-*fonts	\
                google-droid-*fonts mgopen-*fonts                       \
                mona-*fonts oflb-*fonts yanone-*fonts ghostscript-fonts	\
                xorg-x11-fonts* liberation-*fonts
		       
	#rpm -q chkfontpath
	#if [[ "$?" == 0 ]] ; then
	#
	#	OkMsg "chkfontpath already installed"
	#
	#else
	#
	#	CHKFONTPATH="chkfontpath-1.10.1-2.fc11.i586.rpm"
	#	IsX86_64 && CHKFONTPATH="chkfontpath-1.10.1-2.fc11.x86_64.rpm"
	#
	#	cd ~
	#	Download name "$CHKFONTPATH"
	#	if [[ "$?" != 0 ]] ; then
	#
	#		ErrMsg "Could not download package $CHKFONTPATH"
	#		return 1
	#
	#	fi
	#
	#	dnf install --nogpgcheck -y "$CHKFONTPATH"
	#	if [[ "$?" != 0 ]] ; then
	#
	#		ErrMsg "Could not install package $CHKFONTPATH"
	#		return 1
	#
	#	fi
	#
	#fi

	#rm -rf "$CHKFONTPATH"

	rpm -q msttcorefonts
	[[ "$?" == 0 ]] && OkMsg "msttcorefonts already installed" && return 0

	rpm -q wget
	[[ "$?" != 0 ]] && ErrMsg "Could not install wget" && return 1

	FONTSPACKAGE="msttcore-fonts-2.5-1.noarch.rpm"

	cd ~
	[[ -f "$FONTSPACKAGE" ]] && rm -rf "$FONTSPACKAGE"

	Download name "$FONTSPACKAGE"

	[[ "$?" != 0 ]] && ErrMsg "Could not download $FONTSPACKAGE" && return 1

	dnf install --nogpgcheck -y --disableplugin=refresh-packagekit "$FONTSPACKAGE"

	[[ "$?" != 0 ]] && ErrMsg "Could not install $FONTSPACKAGE" && return 1

	rm -rf "$FONTSPACKAGE"
}
