GoogleRepo() {

	if [[ -f /etc/yum.repos.d/google.repo ]]; then

		#sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/google.repo
		#wget https://dl-ssl.google.com/linux/linux_signing_key.pub
		#rpm --import linux_signing_key.pub
		#rm -rf linux_signing_key.pub
		
		OkMsg "Google repo already installed"		
		return 0
	fi

	IsX86_64
	if [[ "$?" == 0 ]]; then
cat << EOF > /etc/yum.repos.d/google.repo
[google]
name=Google - i386
baseurl=http://dl.google.com/linux/rpm/stable/i386
enabled=0
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub  

[google-testing]
name=Google testing - i386
baseurl=http://dl.google.com/linux/rpm/testing/i386
enabled=0
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

[google64]
name=Google – \$basearch
baseurl=http://dl.google.com/linux/rpm/stable/\$basearch
enabled=0
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
	else
cat << EOF > /etc/yum.repos.d/google.repo
[google]
name=Google - i386
baseurl=http://dl.google.com/linux/rpm/stable/i386
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

[google-testing]
name=Google Testing - i386
baseurl=http://dl.google.com/linux/rpm/testing/i386
enabled=0
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
	fi

	if [[ "$?" != 0 ]]; then
        	ErrMsg "Could not create google repo file"
		return 1
	fi
}
