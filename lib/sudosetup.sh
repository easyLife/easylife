SudoSetup() {

	echo "[$FUNCNAME]"

	[[ -z "$USERNAME" ]] && ErrMsg "USERNAME variable is empty" && return 1

	[[ ! -e /etc/sudoers ]] && ErrMsg "sudoers file does not exist" && return 1

	cat /etc/group | grep wheel | grep "$USERNAME"
	[[ "$?" == 0 ]] && OkMsg "User already in wheel group" && return 0	

	tail /etc/sudoers | grep "$USERNAME"
	[[ "$?" == 0 ]] && OkMsg "User already in sudoers file" && return 0

	echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
	[[ "$?" == 0 ]] && OkMsg "$FUNCNAME for $USERNAME" && return 0

}
