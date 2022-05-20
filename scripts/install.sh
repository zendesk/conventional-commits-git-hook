#!/bin/sh

script_file="https://raw.githubusercontent.com/holmeso/conventional-commits-git-hook/master/commit-msg-hook.sh";

init() {
    if [ -n "$1" ]; then
        echo "Unsupported argument '$1'";
    fi

    destination="${PWD}/.git/hooks";

    curl $script_file -o "${destination}/commit-msg";
    chmod u+x "${destination}/commit-msg";

    printf "\nInstalled \x1B[33mcommit-msg\033[0m hook in \x1B[32m%s\033[0m.\n" "$destination";
    echo "More about Conventional Commits: https://www.conventionalcommits.org/";
}

init "$1";
