Java64() {

	echo "[$FUNCNAME]"

	IsX86_64
	[[ "$?" != 0 ]] && ErrMsg "Not a x86_64 Operating System" && return 1

	JAVAPACKAGE=jre-6u29-linux-x64.bin
	JAVALINKNAME=jre-1.6.0u29-sun-x64
	JAVAPLUGINNAME=libjavaplugin.so.x86_64
	JAVAUNPACKEDNAME=jre1.6.0_29

	JAVAINSTALLFOLDER=/opt/jre1.6.0_29_x64

	PRIORITY=17000
	IsX86_64 && PRIORITY=18000

	if [[ -d $(readlink /usr/lib/jvm/"$JAVALINKNAME") ]]; then

		OkMsg "$JAVALINKNAME seems to be installed on $(readlink /usr/lib/jvm/$JAVALINKNAME)"
		return 0

	fi

	# Install dependencies
	yum -y install compat-libstdc++-33 compat-libstdc++-296 wget expect system-switch-java

	[[ "$?" != 0 ]] && ErrMsg "Could not install required packages" && return 1


	cd ~
	rm -rf "$JAVAPACKAGE"
	
	Download noname "$JAVAPACKAGE"
	
	[[ "$?" != 0 ]] && ErrMsg "Could not download $JAVAPACKAGE" && return 1
				
	chmod +x "$JAVAPACKAGE"

	# Run install program and use expect to automatically answer yes to the license reading and agreement
	/usr/bin/expect -c \
		"set timeout -1; spawn ./$JAVAPACKAGE; sleep 1; send -- q\r; sleep 1; send -- yes\r; expect eof"


	# Move installation folder to /opt
	mkdir -p /opt
	
	mv "$JAVAUNPACKEDNAME" "$JAVAINSTALLFOLDER"

				
	# Remove package
	rm -rf "$JAVAPACKAGE"


	# Create the default java-toolsets paths for Sun Java (use galternatives to edit it later if you want)

	/bin/mkdir -p /usr/lib/jvm	# create /usr/lib/jvm folder if not present (needed for Livecds)
	
	/bin/ln -s "$JAVAINSTALLFOLDER" /usr/lib/jvm/"$JAVALINKNAME" > /dev/null


	# Allow java in SELinux (Fedora 10 Beta)
	# if [[ -f /selinux/enforce ]] && chcon -t unconfined_execmem_exec_t "$JAVAINSTALLFOLDER"/bin/java
	
	# Remove previous alternative
	/usr/sbin/alternatives --remove java /usr/lib/jvm/jre-1.6.0u25-sun-x64/bin/java &> /dev/null
	/usr/sbin/alternatives --remove java /usr/lib/jvm/jre-1.6.0u24-sun-x64/bin/java &> /dev/null
		  
	# Install Sun Java as an alternative and set it with the higest priority
	/usr/sbin/alternatives --install \
		       /usr/bin/java java /usr/lib/jvm/"$JAVALINKNAME"/bin/java "$PRIORITY"

	/usr/sbin/alternatives --auto java 
				
			
	# Install firefox plugin
	IsX86_64
	if [[ "$?" == 0 ]]; then

		alternatives --display "$JAVAPLUGINNAME" | grep \
			-i /usr/lib/jvm/"$JAVALINKNAME"/lib/amd64/libnpjp2.so
	
		if [[ "$?" == 1 ]]; then
	
			/usr/sbin/alternatives --install				\
	       		/usr/lib64/mozilla/plugins/libjavaplugin.so "$JAVAPLUGINNAME"	\
			/usr/lib/jvm/"$JAVALINKNAME"/lib/amd64/libnpjp2.so "$PRIORITY"
				
			/usr/sbin/alternatives --auto "$JAVAPLUGINNAME"
		
		fi

		[[ -L /usr/lib64/mozilla/plugins/libjavaplugin.so ]] || ln -s 				\
			/etc/alternatives/"$JAVAPLUGINNAME" /usr/lib64/mozilla/plugins/libjavaplugin.so

	fi


}
