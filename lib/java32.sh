Java32() {

	echo "[$FUNCNAME]"

	JAVAPACKAGE=jre-7u45-linux-i586.tar.gz
	JAVALINKNAME=jre-1.7.0u45-sun-i586
	JAVAPLUGINNAME=libjavaplugin.so
	JAVAUNPACKEDNAME=jre1.7.0_45

	JAVAINSTALLFOLDER=/opt/"$JAVAUNPACKEDNAME"-i586
	
	PRIORITY=180000
	IsX86_64 && PRIORITY=170000

	if [[ -d $(readlink /usr/lib/jvm/"$JAVALINKNAME") ]]; then

		OkMsg "$JAVALINKNAME seems to be installed on $(readlink /usr/lib/jvm/$JAVALINKNAME)"
		return 0

	fi

	# Install dependencies
	yum install -y --disableplugin=refresh-packagekit compat-libstdc++-33 compat-libstdc++-296 wget system-switch-java

	[[ "$?" != 0 ]] && ErrMsg "Could not install required packages" && return 1

	cd ~
	rm -rf "$JAVAPACKAGE"
	
	Download noname "$JAVAPACKAGE"
	
	[[ $? != 0 ]] && ErrMsg "Could not download $JAVAPACKAGE" && return 1
	
	# unpack and mv to /opt with new name
	mkdir -p /opt
	tar zxvf "$JAVAPACKAGE"
	mv "$JAVAUNPACKEDNAME" "$JAVAINSTALLFOLDER"
			
	# Remove downloaded package
	rm -rf "$JAVAPACKAGE"


	# Create the default java-toolsets paths for Sun Java (use galternatives to edit it later if you want)

	/bin/mkdir -p /usr/lib/jvm	# create /usr/lib/jvm folder if not present (needed for Livecds)
	
	/bin/ln -s "$JAVAINSTALLFOLDER" /usr/lib/jvm/"$JAVALINKNAME" > /dev/null


	# Allow java in SELinux (Fedora 10 Beta)
	# if [[ -f /selinux/enforce ]] && chcon -t unconfined_execmem_exec_t "$JAVAINSTALLFOLDER"/bin/java

	# Remove previous alternative
	#/usr/sbin/alternatives --remove java /usr/lib/jvm/jre-1.6.0u25-sun-i586/bin/java &> /dev/null
	#/usr/sbin/alternatives --remove java /usr/lib/jvm/jre-1.6.0u24-sun-i586/bin/java &> /dev/null

		  
	# Install Sun Java as an alternative and set it with the higest priority
	/usr/sbin/alternatives --install \
		       /usr/bin/java java /usr/lib/jvm/"$JAVALINKNAME"/bin/java "$PRIORITY"

	/usr/sbin/alternatives --auto java 
				
	# Display installed version
	java -version
		
	# Install firefox plugin

	IsX86_64
	if [[ "$?" != 0 ]]; then

		# Install Sun Java Plugin as an alternative of libjavaplugin and set it with the higest priority
		alternatives --display libjavaplugin.so | grep \
			-i /usr/lib/jvm/"$JAVALINKNAME"/lib/i386/libnpjp2.so
		if [[ "$?" == 1 ]]; then
	
			/usr/sbin/alternatives --install				\
			/usr/lib/mozilla/plugins/"$JAVAPLUGINNAME" "$JAVAPLUGINNAME"	\
			/usr/lib/jvm/"$JAVALINKNAME"/lib/i386/libnpjp2.so "$PRIORITY"
				
			/usr/sbin/alternatives --auto "$JAVAPLUGINNAME"
		
		fi

	fi

}
