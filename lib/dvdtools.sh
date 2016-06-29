DvdTools() {
	echo "[$FUNCNAME]"

	dnf install -y --disableplugin=refresh-packagekit brasero

	if [[ "$?" == 0 ]]; then
        OkMsg "Packages installed"
    fi
    ErrMsg "Could not install packages"
 
	#Call libdvdcss function
	Libdvdcss
}
