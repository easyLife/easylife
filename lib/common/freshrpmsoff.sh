FreshrpmsOff() {

	[[ -f /etc/yum.repos.d/freshrpms.repo ]] && sed -i "s/enabled=1/enabled=0/g" /etc/yum.repos.d/freshrpms.repo

	[[ $? != 0 ]] && return 1

}
