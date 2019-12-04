source common.sh

function install_macos_pkg() {
    local pkg_url="${1}"
    local pkgdir=$(mktemp -d)
    local pkgfile="${pkgdir}/tmp.pkg"
    # WHY: macos installer is fucked up and needs the file to have
    # the right suffix, and mktemp on macos does not seem to have a suffix option

    printf "Installing macos pkg from URL: %s" "${pkg_url}"
    curl -fL "${pkg_url}" --output "${pkgfile}"
    sudo installer -pkg "${pkgfile}" -target /
    rm -rf "${pkgdir}"
}

function install_macos_homebrew(){
    if [ "$(is_installed "brew help")" == "yes" ]; then
        echo "brew is already installed, skipping install"
        return
    fi
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_macos_go(){
    if [ "$(is_installed "go version")" == "yes" ]; then
        echo "go is already installed, skipping install"
        return
    fi
    local version="${1}"
    install_macos_pkg "https://dl.google.com/go/go${version}.darwin-amd64.pkg"
}

function install_macos_docker(){
    if [ "$(is_installed "docker --version")" == "yes" ]; then
        echo "docker is already installed, skipping install"
        return
    fi
    brew cask install docker
}

function install_macos_deps() {
    local go_version="${1}"
    local gcloud_version="${2}"

    install_macos_homebrew
    install_macos_go "${go_version}"
    install_macos_docker
    install_gcloud "${gcloud_version}" "darwin"

    fix_git_for_go_get
    configure_docker_credentials
}
