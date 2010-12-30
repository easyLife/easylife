Theme() {

	echo "[$FUNCNAME]"

	IsGnome
	[[ "$?" != 0 ]] && ErrMsg "Not Gnome running" && return 1

	ICONSET="elementary-mod.tar.gz"
	#ICONBASENAME="$(basename $ICONSET .tar.bz2)"
	ICONBASENAME="elementary-mod"

	ICONINSTALLED=0

	if [[ -d /usr/share/icons/"$ICONBASENAME" ]]; then

		OkMsg "Iconset already installed. Applying..."

		sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /desktop/gnome/interface/icon_theme "$ICONBASENAME"

		[[ "$?" == 0 ]] && ICONINSTALLED=1

	fi


	rpm -q wget > /dev/null

	if [[ "$?" != 0 ]]; then

		yum install -y wget
		
		[[ "$?" != 0 ]] && ErrMsg "Could not install wget" && return 1

	fi
	
	
	cd ~
	[[ -f "$ICONSET" ]] && rm -rf "$ICONSET"

	if [[ "$ICONINSTALLED" != 1 ]]; then

		Download name "$ICONSET"
	
		[[ "$?" != 0 ]] && ErrMsg "Could not download iconset package" && return 1	

		#[[ ! -d "$USERHOME"/.icons/ ]] && mkdir -p "$USERHOME"/.icons/

		#Pay attention to file extension (tar.bz2 -jxvf //// tar.gz -zxvf)
		#tar jxvf "$ICONSET" --directory="$USERHOME/.icons/"
		tar zxvf "$ICONSET" --directory=/usr/share/icons/

		[[ "$?" != 0 ]] && ErrMsg "Could not install icon theme" && return 1
	
		gtk-update-icon-cache -f -i /usr/share/icons/"$ICONBASENAME"

		[[ -f "$ICONSET" ]] && rm -rf "$ICONSET"

		sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
				--set /desktop/gnome/interface/icon_theme "$ICONBASENAME"
	
		[[ "$?" == 0 ]] && OkMsg "$ICONBASENAME iconset installed"

	fi

	# Install gtk murrine engine, since it's essential to sonar
	yum install -y gtk-murrine-engine

	[[ "$?" != 0 ]] && ErrMsg "Could not install murrine engine" && return 1


	# Install theme
	THEME="Sonar.tar.gz"
	THEMEBASENAME="Sonar"

	if [[ -d /usr/share/themes/"$THEMEBASENAME" ]]; then

		OkMsg "Theme $THEMEBASENAME already installed. Applying..."

		sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /desktop/gnome/interface/gtk_theme "$THEMEBASENAME"

		sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /apps/metacity/general/theme "$THEMEBASENAME"

		return 0

	fi

	cd ~
	[[ -f "$THEME" ]] && rm -rf "$THEME"

	Download name "$THEME"

	[[ "$?" != 0 ]] && ErrMsg "Could not download theme package" && return 1

	# Be careful with tar options (bz2 or gz?)
	tar zxvf "$THEME" --directory=/usr/share/themes/

	[[ "$?" != 0 ]] && ErrMsg "Could not install theme" && return 1

	[[ -f "$THEME" ]] && rm -rf "$THEME"

	sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /desktop/gnome/interface/gtk_theme "$THEMEBASENAME"

	sudo -u "$USERNAME" "$DSBA" gconftool-2 --type string \
			--set /apps/metacity/general/theme "$THEMEBASENAME"

	[[ "$?" == 0 ]] && OkMsg "$THEMEBASENAME theme installed" && return 0

}
