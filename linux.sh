source common.sh

function bootstrap_linux() {
    echo
    echo "TODO: Install deps, for now just configuration is being done"
    echo

    fix_git_for_go_get
    configure_docker_credentials
}
