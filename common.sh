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
