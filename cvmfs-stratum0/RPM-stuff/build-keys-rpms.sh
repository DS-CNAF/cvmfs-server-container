RPM_STUFF_PATH="/root/RPM-stuff"

OPTION="$1"
CVMFS_REPO_NAME="$2"

"$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        
case "$OPTION" in
    "--pub")
        echo -n "Exporting public key for repo $CVMFS_REPO_NAME... "
        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-pub-key-"$CVMFS_REPO_NAME".spec
        rm -f "$RPM_STUFF_PATH"/*"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-pub-key-1-1.x86_64.rpm /etc/cvmfs/keys
        echo "done"
        echo "The public key is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-pub-key-1-1.x86_64.rpm"
        ;;
    "--relman")
        echo -n "Exporting release manager keys set for $CVMFS_REPO_NAME... "
        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-relman-key-"$CVMFS_REPO_NAME".spec
        rm -f "$RPM_STUFF_PATH"/*"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-relman-key-1-1.x86_64.rpm /etc/cvmfs/keys
        echo "done"
        echo "The public key is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-relman-key-1-1.x86_64.rpm"
        ;;
    *) 
        echo "FATAL: the second argument should be either --pub (public key export) or --relman (to export all the keys needed by Release Managers). Aborting."
        ;;
esac

unset RPM_STUFF_PATH