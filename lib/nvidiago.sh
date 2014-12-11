NvidiaGo() {

	echo "[$FUNCNAME]"

	COUNT=0
	for NAME in ${FUNCTIONS[@]}; do
		
		[[ "$NAME" == *"Nvidia"* ]] && let COUNT++

	done

	if [[ $COUNT -gt 1 ]]; then

		ErrMsg "Please, select only one Nvidia option to install." && return 1

	fi

	# Check if user really has a nvidia video card
	VGA=$(lspci | grep -i nvidia | grep VGA) > /dev/null
	if [[ "$?" != 0 ]]; then

		ErrMsg "No nVidia card detected" && return 1

	fi

	# If anything from nvidia is installed, abort...
	PKGSINSTALLED=$(rpm -qa *kmod-nvidia*)
	if [[ -n "$PKGSINSTALLED" ]]; then

		OkMsg "nVidia driver seems to be already installed." && return 0

	fi

	yum install -y --disableplugin=refresh-packagekit kernel-devel kernel-headers
	yum update -y --disableplugin=refresh-packagekit kernel kernel-devel kernel-headers

	# $NVIDIAPKG is pulled from either nvidia.sh or nvidia173xx.sh
	yum install -y --disableplugin=refresh-packagekit --nogpgcheck "$NVIDIAPKG"
	yum update -y --disableplugin=refresh-packagekit --nogpgcheck kmod-nvidia*

	rpm -q akmod-nvidia > /dev/null	
	if [[ "$?" == 0 ]]; then
		
		# Add rdblacklist=nouveau to the end of all "kernel" lines in grub.conf
		#[[ -f /boot/grub/grub.conf ]] && sed -i '/root=/s|$| rdblacklist=nouveau|' /boot/grub/grub.conf

		# Fix selinux to allow the driver to load
		#setsebool -P allow_execstack on

		OkMsg "nVidia driver installed. Reboot your system." && return 0

	else

		ErrMsg "Could not install package $NVIDIAPKG" && return 1

	fi


}

