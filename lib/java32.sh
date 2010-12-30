Java32() {

	echo "[$FUNCNAME]"

	JAVAPACKAGE=jre-6u21-linux-i586.bin
	JAVALINKNAME=jre-1.6.0u21-sun-i586
	JAVAPLUGINNAME=libjavaplugin.so
	JAVAUNPACKEDNAME=jre1.6.0_21

	JAVAINSTALLFOLDER=/opt/jre1.6.0_21_i586
	
	PRIORITY=18000
	IsX86_64 && PRIORITY=17000

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
	
	[[ $? != 0 ]] && ErrMsg "Could not download $JAVAPACKAGE" && return 1
				
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
	/usr/sbin/alternatives --remove java /usr/lib/jvm/jre-1.6.0u19-sun-i586/bin/java &> /dev/null
	/usr/sbin/alternatives --remove java /usr/lib/jvm/jre-1.6.0u20-sun-i586/bin/java &> /dev/null

		  
	# Install Sun Java as an alternative and set it with the higest priority
	/usr/sbin/alternatives --install \
		       /usr/bin/java java /usr/lib/jvm/"$JAVALINKNAME"/bin/java "$PRIORITY"

	/usr/sbin/alternatives --auto java 
				
			
	# Install firefox plugin

	IsX86_64
	if [[ "$?" != 0 ]]; then

		# Install Sun Java Plugin as an alternative of libjavaplugin and set it with the higest priority
		alternatives --display libjavaplugin.so | grep \
			-i /usr/lib/jvm/"$JAVALINKNAME"/plugin/i386/ns7/libjavaplugin_oji.so
		if [[ "$?" == 1 ]]; then
	
			/usr/sbin/alternatives --install				\
			/usr/lib/mozilla/plugins/"$JAVAPLUGINNAME" "$JAVAPLUGINNAME"	\
			/usr/lib/jvm/"$JAVALINKNAME"/plugin/i386/ns7/libjavaplugin_oji.so "$PRIORITY"
				
			/usr/sbin/alternatives --auto "$JAVAPLUGINNAME"
		
		fi

	fi

	mozilla-plugin-config -i -g > /dev/null

}
