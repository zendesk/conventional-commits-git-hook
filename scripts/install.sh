#!/bin/sh

script_file="https://raw.githubusercontent.com/craicoverflow/sailr/master/sailr.sh"

function init {
    if [ ! -z $1 ]; then
        echo "Unsupported argument '$1'"
    fi

    destination="${PWD}/.git/hooks"

    download_status=$(curl $script_file -o "${destination}/commit-msg")
    chmod u+x "${destination}/commit-msg"

    echo -e "\nInstalled Sailr as \e[33mcommit-msg\033[0m hook in \e[32m$destination\033[0m."
    echo "More about Conventional Commits: https://www.conventionalcommits.org/"
}

init $1
