Ati() {

	echo "[$FUNCNAME]"

	# Check if user really has a ati video card
	VGA=$(lspci | grep -i ati | grep VGA) > /dev/null
	if [[ "$?" != 0 ]]; then

		ErrMsg "No ATI card detected" && return 1

	fi

	# If anything from fglrx is installed, abort...
	PKGSINSTALLED=$(rpm -qa *kmod-fglrx*)
	if [[ -n "$PKGSINSTALLED" ]]; then

		OkMsg "ATI driver seems to be already installed." && return 0

	fi

	yum install -y kernel-devel kernel-headers
	yum update -y kernel kernel-devel kernel-headers
	
	yum install -y akmod-fglrx
	if [[ "$?" == 0 ]]; then

		OkMsg "ATI driver installed. Reboot your system." && return 0

	else

		ErrMsg "Could not install package akmod-fglrx" && return 1

	fi

	# backup initrd
	mv /boot/initrd-$(uname -r).img /boot/initrd-$(uname -r).img.backup

	# remake initrd for the kernel (so the radeon module is not force loaded)
	mkinitrd -v /boot/initrd-$(uname -r).img  $(uname -r)

}

