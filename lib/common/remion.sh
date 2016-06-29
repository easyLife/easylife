RemiOn() {
    echo "[$FUNCNAME]"

    if [[ -f /etc/yum.repos.d/remi.repo ]]; then
        sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/remi.repo
        OkMsg "Remi repo installed and disabled"
        return 0
    fi

    wget http://rpms.remirepo.net/fedora/remi.repo
    if [[ ! -f remi.repo ]]; then
        ErrMsg "Could not get Remi repo file"
        return 1
    fi

    mv remi.repo /etc/yum.repos.d/
    if [[ "$?" != 0 ]]; then
        ErrMsg "Could not create Remi repo file"
        return 1
    fi
    return 0
}
