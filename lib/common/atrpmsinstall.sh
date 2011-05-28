AtrpmsInstall() {

	echo "[$FUNCNAME]"

	if [[ -f /etc/yum.repos.d/atrpms.repo ]]; then

		sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/atrpms.repo
		OkMsg "ATrpms repo installed and disabled"
		return 0

	fi

cat << 'EOF' > /etc/yum.repos.d/atrpms.repo
[atrpms]
name=Fedora $releasever - $basearch - ATrpms
baseurl=http://dl.atrpms.net/f$releasever-$basearch/atrpms/stable
gpgkey=http://ATrpms.net/RPM-GPG-KEY.atrpms
enabled=0
gpgcheck=1
EOF

	if [[ "$?" != 0 ]]; then

		ErrMsg "Could not create ATrpms repo file"
		return 1

	fi

	return 0

}
