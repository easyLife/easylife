DvdTools() {
	echo "[$FUNCNAME]"

	dnf install -y --disableplugin=refresh-packagekit k9copy devede brasero

	[[ $? != 0 ]] && OkMsg "Packages installed" && return 1

	#Call libdvdcss function
	Libdvdcss
}
