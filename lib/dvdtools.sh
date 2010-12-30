DvdTools() {

	echo "[$FUNCNAME]"

	yum install -y k9copy devede kino brasero

	[[ $? != 0 ]] && OkMsg "Packages installed" && return 1

	#Call libdvdcss function
	Libdvdcss


}
