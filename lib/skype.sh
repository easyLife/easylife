Skype() {

	echo "[$FUNCNAME]"


#	if [[ ! -f /etc/yum.repos.d/skype.repo ]]; then
#
#cat << EOF > /etc/yum.repos.d/skype.repo
#[skype]
#name=Skype Repository
#baseurl=http://download.skype.com/linux/repos/fedora/updates/i586/
#enabled=0
#gpgchek=0
#EOF

#	fi

	# Install 32bit dependencies, since the rpm isn't x86_64
	yum install -y --disableplugin=refresh-packagekit                               \
                libXScrnSaver.i?86 libX11.i?86 libv4l.i?86     			        \
		alsa-plugins-pulseaudio.i?86 qt-x11.i?86 glibc*686 libXScrnSaver*686    \
		libasound.so.2 libXv.so.1 libQtDBus.so.4 libQtGui.so.4 bzip2-libs       \
                cairo-gobject cdparanoia-libs colord js lcms2 libXevie opus orc polkit  \
                qt-mobility qtwebkit soundtouch

	[[ "$?" != 0 ]] && ErrMsg "Package not installed" && return 1

	SKYPEPACKAGE="skype-4.1.0.20-fedora.i586.rpm"

	cd ~
	[[ -f "$SKYPEPACKAGE" ]] && rm -rf "$SKYPEPACKAGE"

	Download noname "$SKYPEPACKAGE"

	[[ "$?" != 0 ]] && ErrMsg "Could not download $SKYPEPACKAGE" && return 1

	yum localinstall -y --nogpgcheck --disableplugin=refresh-packagekit "$SKYPEPACKAGE"

	[[ "$?" != 0 ]] && ErrMsg "Could not install $SKYPEPACKAGE" && return 1

	[[ -f "$SKYPEPACKAGE" ]] && rm -rf "$SKYPEPACKAGE"

}
