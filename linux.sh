source common.sh

function install_linux_gcloud() {
    if [ "$(is_installed "gcloud --version")" == "yes" ]; then
        skip_install_message "gcloud"
        return
    fi

    local version="${1}"
    local os="${2}"
    local workdir=$(mktemp -d)
    local installdir="$HOME/.local"
    local sdkdir="${installdir}/google-cloud-sdk"

    mkdir -p "${installdir}"
    printf "google cloud SDK will be installed at: %s\n" "${sdkdir}"
    cd "${workdir}"
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${version}-${os}-x86_64.tar.gz
    tar zxvf google-cloud-sdk-${version}-${os}-x86_64.tar.gz
    mv google-cloud-sdk ${installdir}
    cd ${sdkdir}
    ./install.sh
    rm -rf ${workdir}
}

function bootstrap_linux() {
    echo
    echo "TODO: Install deps, for now just configuration is being done"
    echo

    fix_git_for_go_get
    configure_docker_credentials
}
