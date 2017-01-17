Theme() {

	echo "[$FUNCNAME]"

	#IsGnome
	#[[ "$?" != 0 ]] && ErrMsg "Not Gnome running" && return 1

        dnf install -y --disableplugin=refresh-packagekit  \
            elementary-icon-theme numix-*                  \
            echo-icon-theme tango-icon-theme               \
            tango-icon-theme-extras gnome-tweak-tool

        if [[ "$?" != 0 ]]; then
            ErrMsg "Could not install packages"
		        return 1
       	fi

        OkMsg "Themes installed. Select your theme with gnome-tweak-tool."

        rpm -q numix-icon-theme > /dev/null
        if [[ "$?" == 0 ]]; then
            sudo -u "$USERNAME" gsettings set \
		            org.gnome.desktop.interface icon-theme 'Numix-Circle'
            if [[ "$?" == 0 ]]; then
                OkMsg "Numix-Circle icon theme selected"
            fi
        fi

        # This is causing too much Gtk-WARNING **: 
        # Theme parsing error: gtk.css:4475:16: Expected a string.
        #
        #rpm -q numix-gtk-theme > /dev/null
        #if [[ "$?" == 0 ]]; then
        #    sudo -u "$USERNAME" gsettings set \
        #        org.gnome.desktop.interface gtk-theme 'Numix'
        #fi
}
