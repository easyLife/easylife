MediaPlayers() {
	echo "[$FUNCNAME]"

	# Install DVD stuff and firefox totem plugin viewer
	dnf install -y --disableplugin=refresh-packagekit libdvdnav libdvdread

	[[ "$?" != 0 ]] && ErrMsg "Could not install packages" && return 1

	# Remove thumbnails formed before media support was installed
	rm -rf "~$USERNAME/.cache/thumbnails/*"

	dnf install -y  --disableplugin=refresh-packagekit                              \
                        mplayer mplayer-gui kplayer vlc avidemux-* banshee amarok	\
		       	xmms xmms-mp3 xmms-crossfade xmms-faad2 xmms-flac		\
			xmms-pulse audio-convert-mod
		       	
		       
	[[ "$?" != 0 ]] && ErrMsg "Could not install packages" && return 1

	# Some fixes for mplayer - not necessary anymore
	#sed -i 's/flip-hebrew/#flip-hebrew/' /etc/mplayer/mplayer.conf

	#sed -i 's/ao_driver = "alsa"/ao_driver = "pulse"/' "$USERHOME"/.mplayer/gui.conf

	# Set proper enconding for pt_BR subtitles
	if [[ "$EL_LANG" == "pt_BR" ]]; then
		if [[ -f "$USERHOME"/.mplayer/gui.conf ]]; then
			grep sub_cp "$USERHOME"/.mplayer/gui.conf
			[[ "$?" == "1" ]] && echo "sub_cp = \"iso-8859-1\"" >> "$USERHOME"/.mplayer/gui.conf
		fi
	fi
	#Call libdvdcss function
	Libdvdcss
}
