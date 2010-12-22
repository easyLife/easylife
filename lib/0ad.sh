# 0AD - Game - http://wildfiregames.com/0ad/
0ad() {

    echo "[$FUNCNAME]"

    # Generate repo
    if [[ ! -f /etc/yum.repos.d/fedora-0ad.repo ]]; then

cat << EOF > /etc/yum.repos.d/fedora-0ad.repo
[fedora-0ad]
name=Cross-Platform RTS Game of Ancient Warfare
baseurl=http://repos.fedorapeople.org/repos/bioinfornatics/0ad/fedora-\$releasever/\$basearch/
enabled=1
skip_if_unavailable=1
gpgcheck=0

[fedora-0ad-source]
name=Cross-Platform RTS Game of Ancient Warfare - Source
baseurl=http://repos.fedorapeople.org/repos/bioinfornatics/0ad/fedora-\$releasever/SRPMS
enabled=0
skip_if_unavailable=1
gpgcheck=0
EOF

    fi

    # Install libraries and dependencies
    yum install -y mesa-libGLw mesa-libGL mesa-libGLw-devel mesa-libGL-devel @fedora-packager

    # Check if the render acceleration library libtxc_dxtn is installed
    # http://wildfiregames.com/users/code/libtxc_dxtn070518.tar.gz
    if [[ ! -f /usr/lib/libtxc_dxtn.so ]]; then
        LIBTXCPKG='libtxc_dxtn070518.tar.gz'
        cd /usr/local/src
        Download name "$LIBTXCPKG"
        tar -xzf libtxc_dxtn070518.tar.gz
        rm -f libtxc_dxtn070518.tar.gz
        cd libtxc_dxtn
        make install
        
        # Restore SELinux permissions
        restorecon -R /usr/lib
    fi

    # Install 0ad
    yum install -y 0ad
}
