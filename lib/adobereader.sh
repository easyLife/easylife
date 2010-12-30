AdobeReader() {

	echo "[$FUNCNAME]"

	# Clear variable
	unset ADOBEPKG

	# Select correct package name for download
	[[ "$EL_LANG" = "pt_BR" ]] && ADOBEPKG="AdobeReader_ptb-8.1.2-1.i486.rpm"
	[[ "$EL_LANG" = "pt_PT" ]] && ADOBEPKG="AdobeReader_ptb-8.1.2-1.i486.rpm"
	[[ "$EL_LANG" = "en_US" ]] && ADOBEPKG="AdobeReader_enu-8.1.2-1.i486.rpm"
	[[ "$EL_LANG" = "es_ES" ]] && ADOBEPKG="AdobeReader_esp-8.1.2-1.i486.rpm"
	[[ "$EL_LANG" = "nl_NL" ]] && ADOBEPKG="AdobeReader_nld-8.1.2-1.i486.rpm"
	[[ "$EL_LANG" = "de_DE" ]] && ADOBEPKG="AdobeReader_deu-8.1.2-1.i486.rpm"
	[[ "$EL_LANG" = "it_IT" ]] && ADOBEPKG="AdobeReader_ita-8.1.2-1.i486.rpm"

	# For any other languages (if ADOBEPKG is empty), set enu package as the default
	ADOBEPKG="${ADOBEPKG:-AdobeReader_enu-8.1.2-1.i486.rpm}"


	rpm -q "${ADOBEPKG%%-*}"

	[[ "$?" == 0 ]] && OkMsg "Adobe Reader already installed" && return 0

	cd ~
	rm -rf "$ADOBEPKG"

	Download name "$ADOBEPKG"

	[[ "$?" != 0 ]] && ErrMsg "Could not download package" && return 1

	yum localinstall -y --nogpgcheck "$ADOBEPKG"
	
	[[ "$?" != 0 ]] && ErrMsg "Could not install package" && return 1

	# If SElinux is on, add the policy to make adobe reader firefox plugin work:
	if [[ -f /selinux/enforce ]]; then

		/usr/bin/chcon -t textrel_shlib_t /usr/lib/mozilla/plugins/nppdf.so
		/usr/bin/chcon -t textrel_shlib_t /usr/lib/firefox-*/plugins/nppdf.so

	fi

	rm -rf "$ADOBEPKG"

	mozilla-plugin-config -i -g > /dev/null

}
