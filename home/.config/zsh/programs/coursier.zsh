case ${OSTYPE} in
    darwin*)
        export PATH="$PATH:/Users/${USER}/Library/Application Support/Coursier/bin"
        ;;
    *)
        # setting for linux
        ;;
esac

