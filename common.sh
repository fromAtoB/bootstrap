function is_installed() {
    local testcmd="${1}"
    eval "${testcmd} &> /dev/null" && echo "yes" || echo "no"
}

function message() {
    echo
    echo "==================================================="
    echo "${1}"
    echo "==================================================="
    echo
}

function install_message() {
    message "Installing ${1}"
}

function skip_install_message() {
    message "${1} already installed, skipping it"
}

function install_gcloud() {
    # WHY: Perhaps it will be useful to linux distro who dont have gcloud package
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

function fix_git_for_go_get(){
    local gitcfg_path="${HOME}/.gitconfig"
    local hascfg=$(grep "ssh://git@github.com/" "${gitcfg_path}" &>/dev/null && echo "yes" || echo "no")

    if [ "$hascfg" == "yes" ]; then
        message "git is already configured, skipping config"
        return
    fi

    echo "configuring git"
    echo -e '[url "ssh://git@github.com/"]\n\tinsteadOf = https://github.com/' >> "${gitcfg_path}"
    echo "configured git"
}

function configure_docker_credentials() {
    gcloud auth configure-docker
}
