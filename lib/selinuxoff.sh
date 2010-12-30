SelinuxOff() {

	echo "[$FUNCNAME]"
	
	/usr/sbin/setenforce 0 > /dev/null
	sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux
	sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
 
	cat /etc/selinux/config | grep -i "SELINUX=permissive" > /dev/null && OkMsg "Selinux is in permissive mode now"

}
