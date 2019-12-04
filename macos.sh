source common.sh

function install_macos_pkg() {
    local pkg_url="${1}"
    local pkgfile=$(mktemp)

    printf "Installing macos pkg from URL: %s" "${pkg_url}"
    wget "${pkg_url}"
    sudo installer -pkg "${pkgfile}" -target /
    rm -rf "${pkgfile}"
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
    echo "TODO"
}

function install_macos_docker_compose(){
    echo "TODO"
}

function install_gcloud(){
    echo "TODO"
}

function install_macos_deps() {
    local go_version="${1}"

    install_macos_homebrew
    install_macos_go "${go_version}"
    install_macos_docker
    install_macos_docker_compose
    install_gcloud
}
