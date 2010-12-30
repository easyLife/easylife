UtcOff() {

	echo "[$FUNCNAME]"

	grep -i "UTC=false" /etc/sysconfig/clock && OkMsg "UTC already off" && return 0

	sed -i 's/UTC=true/UTC=false/g' /etc/sysconfig/clock

	[[ $? = 0 ]] && OkMsg "UTC set to off" && return 0
		
}		
