Theme() {

	echo "[$FUNCNAME]"

	#IsGnome
	#[[ "$?" != 0 ]] && ErrMsg "Not Gnome running" && return 1

        dnf install -y --disableplugin=refresh-packagekit                  \
                       elementary-icon-theme                               \
                       echo-icon-theme tango-icon-theme                    \
                       tango-icon-theme-extras

        if [[ "$?" != 0 ]]; then

		ErrMsg "Could not install packages"
		return 1
	
	fi

        rpm -q faenza-icon-theme > /dev/null
        if [[ "$?" == 0 ]]; then

            sudo -u "$USERNAME" gsettings set \
		    org.gnome.desktop.interface icon-theme 'Faenza'

            [[ "$?" == 0 ]] && OkMsg "Themes installed"

        fi

}
