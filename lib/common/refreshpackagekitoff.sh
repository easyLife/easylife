RefreshPackagekitOff() {

	echo "[$FUNCNAME]"

	[[ ! -f /etc/yum/pluginconf.d/refresh-packagekit.conf ]] && return 0

	SWITCH=$(cat /etc/yum/pluginconf.d/refresh-packagekit.conf | grep -i 'enabled=' | cut -d'=' -f2)

	if [[ "$SWITCH" == "0" ]]; then

		OkMsg "Refresh-packagekit yum plugin alredy turned off"
		return 0

	fi

	cp /etc/yum/pluginconf.d/refresh-packagekit.conf /etc/yum/pluginconf.d/refresh-packagekit.conf.el-backup

	# We need to temporarily kill refresh-packgekit in order to use yum without pid locks
	sed -i "s/enabled=1/enabled=0/" /etc/yum/pluginconf.d/refresh-packagekit.conf

	[[ "$?" != 0 ]] && ErrMsg "Could not disable refresh-packagekit plugin." && return 1

	OkMsg "Refresh-packagekit yum plugin temporarily turned off"

	return 0
	
}

