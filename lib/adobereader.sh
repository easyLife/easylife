AdobeReader() {

	echo "[$FUNCNAME]"

	# Clear variable
	unset ADOBEPKG

	# Select correct package name for download
	[[ "$EL_LANG" == "en_US" ]] && ADOBEPKG="AdobeReader_enu"
	[[ "$EL_LANG" == "pt_BR" ]] && ADOBEPKG="AdobeReader_ptb"
	[[ "$EL_LANG" == "pt_PT" ]] && ADOBEPKG="AdobeReader_enu"
	[[ "$EL_LANG" == "es_ES" ]] && ADOBEPKG="AdobeReader_esp"
	[[ "$EL_LANG" == "nl_NL" ]] && ADOBEPKG="AdobeReader_nld"
	[[ "$EL_LANG" == "de_DE" ]] && ADOBEPKG="AdobeReader_deu"
	[[ "$EL_LANG" == "it_IT" ]] && ADOBEPKG="AdobeReader_ita"

	# For any other languages (if ADOBEPKG is empty), set enu package as the default
	ADOBEPKG="${ADOBEPKG:-AdobeReader_enu}"


	rpm -q "${ADOBEPKG%%-*}"

	[[ "$?" == 0 ]] && OkMsg "Adobe Reader already installed" && return 0

	rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm

	dnf install -y --disableplugin=refresh-packagekit "$ADOBEPKG" nspluginwrapper.i686
	
	[[ "$?" != 0 ]] && ErrMsg "Could not install package" && return 1

	# If SElinux is on, add the policy to make adobe reader firefox plugin work:
        selinuxenabled
	[[ "$?" == 0 ]] && /usr/bin/chcon -t textrel_shlib_t /usr/lib/mozilla/plugins/nppdf.so

        # Do we need this?
	mozilla-plugin-config -i -g > /dev/null

}
