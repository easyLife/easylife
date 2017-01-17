NotXorg() {

	echo "[$FUNCNAME]"

	ErrMsg "easyLife only works with GNOME on Xorg"
	echo ' '
	echo "        !!! Please, sign in again selecting 'GNOME on Xorg' session !!!"
    echo ' '
    echo "        Terminating program"
    echo ' '
    printf '        .'
    sleep 2
    COUNTER=0
    while [[ "$COUNTER" -lt 2 ]]; do
    	printf '.'
    	sleep 2
    	let COUNTER=COUNTER+1
    done

	sleep 6
	echo ' '
	echo ' '
	return 1
}

