GetOpt() {

	unset SELECTION

	#Do not insert comments (#) before any line inside zenity
	SELECTION=$(									\
		zenity --list								\
		--title "$GETOPT_MSG_TITLE"						\
		--width="$GETOPT_MSG_WIDTH" --height="$GETOPT_MSG_HEIGHT"		\
		--text "$GETOPT_MSG_TEXT"						\
		--checklist								\
		--column "$COMMON_MSG_CHECK"						\
		--column "$GETOPT_MSG_CONF"						\
		--column "$GETOPT_MSG_DESC"						\
		--window-icon="/usr/share/pixmaps/easylife.png"				\
		FALSE 	ResizeFonts	"$GETOPT_MSG_RESIZEFONTS"			\
		FALSE	SetupKeyboard	"$GETOPT_MSG_SETUPKEYBOARD"			\
		FALSE	SetupWindows	"$GETOPT_MSG_SETUPWINDOWS"			\
		FALSE	Theme		"$GETOPT_MSG_THEME"				\
		FALSE	SsLockOff	"$GETOPT_MSG_SSLOCKOFF"				\
		FALSE	SudoSetup	"$GETOPT_MSG_SUDOSETUP"				\
		FALSE	DesktopLink 	"$GETOPT_MSG_DESKTOPLINK"			\
		FALSE	SelinuxOff 	"$GETOPT_MSG_SELINUXOFF"			\
		FALSE	Flash		"$GETOPT_MSG_FLASH"				\
		FALSE	Nvidia		"$GETOPT_MSG_NVIDIA"				\
		FALSE	Nvidia173xx	"$GETOPT_MSG_NVIDIA173xx"			\
		FALSE	Fonts		"$GETOPT_MSG_FONTS"				\
		FALSE	Utils		"$GETOPT_MSG_UTILS"				\
		FALSE	GoogleApps	"$GETOPT_MSG_GOOGLEAPPS"			\
		FALSE	K3b		"$GETOPT_MSG_K3B"				\
		FALSE	Codecs		"$GETOPT_MSG_CODECS"				\
		FALSE	MediaPlayers	"$GETOPT_MSG_MEDIAPLAYERS"			\
		FALSE	DvdTools	"$GETOPT_MSG_DVDTOOLS"				\
		FALSE	Skype		"$GETOPT_MSG_SKYPE"				\
		FALSE	Thunderbird	"$GETOPT_MSG_THUNDERBIRD"			\
		FALSE	Java32		"$GETOPT_MSG_JAVA32"				\
		FALSE	Java64		"$GETOPT_MSG_JAVA64"				\
		2> /dev/null)

}


