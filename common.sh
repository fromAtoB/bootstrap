function is_installed() {
    local testcmd="${1}"
    eval "${testcmd} &> /dev/null" && echo "yes" || echo "no"
}

function install_gcloud() {
    if [ "$(is_installed "gcloud --version")" == "yes" ]; then
        echo "gcloud is already installed, skipping install"
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
        echo "git is already configured, skipping config"
        return
    fi

    echo "configuring git"
    echo -e '[url "ssh://git@github.com/"]\n\tinsteadOf = https://github.com/' >> "${gitcfg_path}"
    echo "configured git"
}

function configure_docker_credentials() {
    gcloud auth configure-docker
}
