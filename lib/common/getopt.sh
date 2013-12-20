GetOpt() {

    unset SELECTION

    #Do not insert comments (#) before any line inside zenity
    SELECTION=$(                                                        \
        yad --list                                                      \
        --title "$GETOPT_MSG_TITLE"                                     \
        --width="$GETOPT_MSG_WIDTH" --height="$GETOPT_MSG_HEIGHT"       \
        --text "$GETOPT_MSG_TEXT"                                       \
        --checklist                                                     \
        --print-column=2                                                \
        --column "$COMMON_MSG_CHECK"                                    \
        --column "$GETOPT_MSG_CONF"                                     \
        --column "$GETOPT_MSG_DESC"                                     \
        --window-icon="/usr/share/pixmaps/easylife.png"                 \
        FALSE   Codecs          "$GETOPT_MSG_CODECS"                    \
        FALSE   DesktopLink     "$GETOPT_MSG_DESKTOPLINK"               \
        FALSE   DvdTools        "$GETOPT_MSG_DVDTOOLS"                  \
        FALSE   Flash           "$GETOPT_MSG_FLASH"                     \
        FALSE   Fonts           "$GETOPT_MSG_FONTS"                     \
        FALSE   Java32          "$GETOPT_MSG_JAVA32"                    \
        FALSE   Java64          "$GETOPT_MSG_JAVA64"                    \
        FALSE   K3b             "$GETOPT_MSG_K3B"                       \
        FALSE   MediaPlayers    "$GETOPT_MSG_MEDIAPLAYERS"              \
        FALSE   Nvidia          "$GETOPT_MSG_NVIDIA"                    \
        FALSE   Nvidia304xx     "$GETOPT_MSG_NVIDIA304xx"               \
        FALSE   Nvidia173xx     "$GETOPT_MSG_NVIDIA173xx"               \
        FALSE   SelinuxOff      "$GETOPT_MSG_SELINUXOFF"                \
        FALSE   SetupKeyboard   "$GETOPT_MSG_SETUPKEYBOARD"             \
        FALSE   SetupWindows    "$GETOPT_MSG_SETUPWINDOWS"              \
        FALSE   Skype           "$GETOPT_MSG_SKYPE"                     \
        FALSE   SsLockOff       "$GETOPT_MSG_SSLOCKOFF"                 \
        FALSE   SudoSetup       "$GETOPT_MSG_SUDOSETUP"                 \
        FALSE   Theme           "$GETOPT_MSG_THEME"                     \
        FALSE   Thunderbird     "$GETOPT_MSG_THUNDERBIRD"               \
        FALSE   Utils           "$GETOPT_MSG_UTILS"                     \
        2> /dev/null)

	# The repoos for 0AD game are not working...
        #FALSE   0AD             "$GETOPT_MSG_0AD"                       \

	##removed - Google now provides rpms directly with specific repos
        #FALSE   GoogleApps      "$GETOPT_MSG_GOOGLEAPPS"                \
	
	#Gnome3 does not allow yet for font size change
        #FALSE   ResizeFonts     "$GETOPT_MSG_RESIZEFONTS"               \


	

	# Radeon open source driver seems to be just better
	#FALSE   Ati          	"$GETOPT_MSG_ATI"	                \

        # Nicemenus won´t be much of a help anymore with new gnome
        #FALSE   NiceMenus       "$GETOPT_MSG_NICEMENUS"                 \

}


