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

function install_macos_essentials(){
    echo "Installing essential tools"
    brew install wget
}

function install_macos_go(){
    if [ "$(is_installed "go version")" == "yes" ]; then
        echo "go is already installed, skipping install"
        return
    fi
    install_macos_pkg "https://dl.google.com/go/go${GO_VERSION}.darwin-amd64.pkg"
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
    install_macos_homebrew
    install_macos_essentials
    install_macos_go
    install_macos_docker
    install_macos_docker_compose
    install_gcloud
}
