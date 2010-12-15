Ntfs() {

	echo "[$FUNCNAME]"

	rpm -q ntfs-3g > /dev/null

	if [[ $? != 0 ]]; then

		yum install -y ntfs-3g
		
		[[ $? != 0 ]] && ErrMsg "Could not install package" && return 1

	fi
		
	/sbin/fdisk -l | grep -i "ntfs" > /dev/null
	
	if [[ $? != 0 ]]; then

		OkMsg "NTFS partitions not found"
		return 1

	fi

	#Get complete NTFS device names (ex: /dev/hda1) and fill them an array 
	NTFSDEVS=($(/sbin/fdisk -l | grep -i ntfs | cut -d " " -f 1))

	#Get NTFS partition names (ex: hda1) and fill an array
	NTFSPART=($(/sbin/fdisk -l | grep -i ntfs | cut -d " " -f 1 | cut -d "/" -f 3))

	COUNT=0
	while [[ -n "${NTFSPART[$COUNT]}" ]]; do

		#Check if partition is already in fstab
		grep -i "${NTFSDEVS[$COUNT]}" /etc/fstab > /dev/null

		# Stop the current instance of while and begin a new one
		[[ $? = 0 ]] && let COUNT++ && continue
					
		#Check if partition is already mounted
		/bin/mount | grep -i ${NTFSDEVS[$COUNT]} > /dev/null

		if [[ $? = 0 ]]; then

			# Get mount point
			MNTPOINT=$(/bin/mount | grep -i "${NTFSDEVS[$COUNT]}" | cut -d" " -f3)

			OkMsg "${NTFSDEVS[$COUNT]} already mounted at $MNTPOINT"

			#Stops the current loop and begins the next in order to chek other partitions
			let COUNT++
			continue

		else

			#Try to get the partition's LABEL (ex: mydisc)
			NTFSLABEL=$(/usr/sbin/ntfslabel -n -f ${NTFSDEVS[$COUNT]} | tail -n 1)
						
			#If there's no partition LABEL, assume the device name as Label (ex: hda1)
			if [[ "$NTFSLABEL" = " " ]] || [[ -z "$NTFSLABEL" ]]; then

				NTFSLABEL="${NTFSPART[$COUNT]}"

			fi

			#Create mount point if it doesn't exist
			[[ ! -d /mnt/"$NTFSLABEL" ]] && mkdir -p /mnt/"$NTFSLABEL"

			#Try to mount the partition on created mount point
			/bin/mount -t ntfs "${NTFSDEVS[$COUNT]}" /mnt/"$NTFSLABEL"
		
			if [[ $? = 0 ]]; then
				
				#Insert partition in fstab so it mounts automatically on next boot
				echo "${NTFSDEVS[$COUNT]} /mnt/$NTFSLABEL auto defaults 0 0" >> /etc/fstab

			else
			
				let COUNT++
				continue

			fi

		fi

	# Add 1 to COUNT so the first "while" continues with next partition
	let COUNT++
	done
	
}

