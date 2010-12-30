Fonts() {

	echo "[$FUNCNAME]"

	yum install -y aajohan-* adf-* aldusleaf-* allgeyer-* apa-new-* apanov-* artwiz-* beteckna-* \
		       bitstream-* bpg-* dejavu-* dustin-* ecolier-* gargi-* gdouros-*               \
		       gfs-* gnu-free-* google-droid-* hartke-aurulent-* mgopen-* mona-* oflb-*      \
		       yanone-* ghostscript-fonts xorg-x11-fonts* liberation-* wget

	rpm -q chkfontpath
	if [[ "$?" == 0 ]] ; then

		OkMsg "chkfontpath already installed"

	else
	
		CHKFONTPATH="chkfontpath-1.10.1-2.fc11.i586.rpm"
		IsX86_64 && CHKFONTPATH="chkfontpath-1.10.1-2.fc11.x86_64.rpm"
	
		cd ~
		Download name "$CHKFONTPATH"
		if [[ "$?" != 0 ]] ; then

			ErrMsg "Could not download package $CHKFONTPATH"
			return 1

		fi

		yum localinstall --nogpgcheck -y "$CHKFONTPATH"
		if [[ "$?" != 0 ]] ; then
	
			ErrMsg "Could not install package $CHKFONTPATH"
			return 1
	
		fi

	fi

	rm -rf "$CHKFONTPATH"


	rpm -q msttcore-fonts
	[[ "$?" == 0 ]] && OkMsg "msttcorefonts already installed" && return 0

	rpm -q wget
	[[ "$?" != 0 ]] && ErrMsg "Could not install wget" && return 1


	FONTSPACKAGE="msttcore-fonts-2.0-2.noarch.rpm"

	cd ~
	[[ -f "$FONTSPACKAGE" ]] && rm -rf "$FONTSPACKAGE"

	Download name "$FONTSPACKAGE"

	[[ $? != 0 ]] && ErrMsg "Could not download $FONTSPACKAGE" && return 1

	yum localinstall --nogpgcheck -y "$FONTSPACKAGE"

	[[ $? != 0 ]] && ErrMsg "Could not install $FONTSPACKAGE" && return 1

	rm -rf "$FONTSPACKAGE"

}
