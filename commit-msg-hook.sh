#!/bin/bash

# set values from config file to variables
function set_config_values() {
    types=('docs' 'feat' 'fix' 'perf' 'refactor' 'style' 'test' 'chore' 'build' 'ci' 'revert' 'merge')
}

# build the regex pattern based on the config file
function build_regex() {
  set_config_values

  regexp="^[.0-9]+$|"

  for type in "${types[@]}"
  do
    regexp="${regexp}$type|"
  done

  regexp="${regexp%|})(\(.+\))?: "
}

# get the first line of the commit message
INPUT_FILE=$1
commit_message=`head -n1 $INPUT_FILE`

# Print out a standard error message which explains
# how the commit message should be structured
function print_error() {
  regular_expression=$2
  echo -e "\n\x1B[31m[Invalid Commit Message]"
  echo -e "------------------------\033[0m\x1B[0m"
  echo -e "Valid types: \x1B[36m${types[@]}\033[0m"
  echo -e "\x1B[37mActual commit message: \x1B[33m\"$commit_message\"\033[0m"
  echo -e "\x1B[37mExample valid commit message: \x1B[36m\"fix(subject): message\"\033[0m"
  echo -e "\x1B[37mRegex: \x1B[33m\"$regexp\"\033[0m"
}

build_regex

if [[ ! $commit_message =~ $regexp ]]; then
  # commit message is invalid according to config - block commit
  print_error
  exit 1
fi
