SetupWindows() {

	echo "[$FUNCNAME]"

	IsGnome
	[[ "$?" != 0 ]] && ErrMsg "Not Gnome running" && return 1


	#sudo -u "$USERNAME" "$DSBA" gconftool-2 -s -t \
	#		bool /apps/nautilus/preferences/always_use_browser true

	#sudo -u "$USERNAME" gsettings set \
	#	org.gnome.nautilus.preferences always-use-browser true

	#[[ "$?" == 0 ]] && OkMsg "Always use nautilus browser set"


	#sudo -u "$USERNAME" "$DSBA" gconftool-2 -s -t \
	#		int /apps/nautilus/preferences/thumbnail_limit 1073741824

	sudo -u "$USERNAME" gsettings set \
		org.gnome.nautilus.preferences thumbnail-limit 1073741824

	[[ "$?" == 0 ]] && OkMsg "Thumbnail 1GB limit set"


	sudo -u "$USERNAME" gsettings set \
		org.gnome.desktop.interface clock-show-date true

	[[ "$?" == 0 ]] && OkMsg "Display date on panel set"


	#sudo -u "$USERNAME" "$DSBA" gconftool-2 -s -t \
	#		string /apps/nautilus/preferences/default_folder_viewer "list_view"

	#sudo -u "$USERNAME" gsettings set \
	#	org.gnome.nautilus.preferences default-folder-viewer "list-view"

	#[[ "$?" == 0 ]] && OkMsg "Default folder viewer list set"


	# A little off topic, but nice to have (theme lock screen and theme splash screen):
	#sudo -u "$USERNAME" gconftool-2 --set \
	#	--type string /apps/gnome-screensaver/lock_dialog_theme "system"

	#sudo -u "$USERNAME" "$DSBA" gconftool-2 --set \
	#	--type bool /apps/gnome-session/options/show_splash_screen true

	
	# Also off topic, but it's nice to have size in human readable form when typing ll on console
	sed -i "s|alias ll='ls -l' 2>/dev/null|alias ll='ls -lh' 2>/dev/null|g" /etc/profile.d/colorls.sh
	sed -i "s|alias ll='ls -l --color=auto' 2>/dev/null|alias ll='ls -lh --color=auto' 2>/dev/null|g" /etc/profile.d/colorls.sh

}
