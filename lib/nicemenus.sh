# Nice menus from the Fedora repo
NiceMenus() {
    echo "[$FUNCNAME]"
    
    yum install -y games-menus preferences-menus \
                   security-menus multimedia-menus
    
    [[ $? != 0 ]] && ErrMsg "Could not install package" && return 1
}
