GetOpt() {

    unset SELECTION

    #Do not insert comments (#) before any line inside zenity
    SELECTION=$(                                                        \
        zenity --list                                                   \
        --title "$GETOPT_MSG_TITLE"                                     \
        --width="$GETOPT_MSG_WIDTH" --height="$GETOPT_MSG_HEIGHT"       \
        --text "$GETOPT_MSG_TEXT"                                       \
        --checklist                                                     \
        --column "$COMMON_MSG_CHECK"                                    \
        --column "$GETOPT_MSG_CONF"                                     \
        --column "$GETOPT_MSG_DESC"                                     \
        --window-icon="/usr/share/pixmaps/easylife.png"                 \
        FALSE   0AD             "$GETOPT_MSG_0AD"                       \
        FALSE   Codecs          "$GETOPT_MSG_CODECS"                    \
        FALSE   DesktopLink     "$GETOPT_MSG_DESKTOPLINK"               \
        FALSE   DvdTools        "$GETOPT_MSG_DVDTOOLS"                  \
        FALSE   Flash           "$GETOPT_MSG_FLASH"                     \
        FALSE   Fonts           "$GETOPT_MSG_FONTS"                     \
        FALSE   GoogleApps      "$GETOPT_MSG_GOOGLEAPPS"                \
        FALSE   Java32          "$GETOPT_MSG_JAVA32"                    \
        FALSE   Java64          "$GETOPT_MSG_JAVA64"                    \
        FALSE   K3b             "$GETOPT_MSG_K3B"                       \
        FALSE   MediaPlayers    "$GETOPT_MSG_MEDIAPLAYERS"              \
        FALSE   NiceMenus       "$GETOPT_MSG_NICEMENUS"                 \
        FALSE   Nvidia173xx     "$GETOPT_MSG_NVIDIA173xx"               \
        FALSE   Nvidia          "$GETOPT_MSG_NVIDIA"                    \
        FALSE   ResizeFonts     "$GETOPT_MSG_RESIZEFONTS"               \
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

}


