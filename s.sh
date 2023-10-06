load() {
    help() {
        echo "Using HiveLoad"
        echo "  -Install --- Install packages from a private repo"
        echo "  -Add-repo --- import a package or repository"
    }
    case ${1/load/} in
        install) 
            echo "Installing HiveLoad"
        ;;
        tstall) 
            alias teload="cd Desktop"
            echo "Created Temp CMD"
            echo "use teload for the command"
            trap exit EXIT
        ;;
        *) 
            echo "$1 Is not found"
            help
        ;;
    esac
}

load
