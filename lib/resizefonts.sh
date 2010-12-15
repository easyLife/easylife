ResizeFonts() {

	echo "[$FUNCNAME]"

	IsGnome
	[[ $? != 0 ]] && return 1

	sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /desktop/gnome/interface/font_name "Sans 9"

	[[ $? = 0 ]] && OkMsg "Font_name set"

				
	sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /desktop/gnome/interface/document_font_name "Sans 9"

	[[ $? = 0 ]] && OkMsg "Document_font_name set"


	sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /apps/nautilus/preferences/desktop_font "Sans 9"

	[[ $? = 0 ]] && OkMsg "Desktop_font set"

	
	sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /apps/metacity/general/titlebar_font "Sans Bold 9"

	[[ $? = 0 ]] && OkMsg "Titlebar_font set"


	# Set a minimum font size for firefox so text on the web never gets too tiny
	# Firefox 3 beta 5 seems to be improved... Not necessary anymore

	#PREFSFOLDER="$(cat $USERHOME/.mozilla/firefox/profiles.ini | grep -i path | cut -d= -f2)"
	
	#[[ -z "$PREFSFOLDER" ]] && return 0

	#PREFSFILE="$USERHOME/.mozilla/firefox/$PREFSFOLDER/prefs.js"

	#[[ ! -f "$PREFSFILE" ]] && return 0

	#FMS="$(cat $PREFSFILE | grep -i font.minimum-size.x-western)"


	#if [[ -z "$FMS" ]] ; then
		
	#	echo 'user_pref("font.minimum-size.x-western", 11);' >> "$PREFSFILE"

	#else

	#	sed -i "s/$FMS/user_pref(\"font.minimum-size.x-western\", 11);/g" "$PREFSFILE"

	#fi
	

}
