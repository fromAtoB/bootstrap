function is_installed() {
    local testcmd="${1}"
    eval "${testcmd} &> /dev/null" && echo "yes" || echo "no"
}

function fix_git_for_go_get(){
    echo "TODO"
}
