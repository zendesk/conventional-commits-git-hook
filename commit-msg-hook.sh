#!/bin/bash

#config_file_name="conventional-commits.json"

# checks that jq is usable
#function check_jq_exists_and_executable {
#if ! [ -x "$(command -v jq)" ]; then
#  echo -e "\`commit-msg\` hook failed. Please install jq."
#  exit 1
#fi
#}

# set values from config file to variables
function set_config_values() {
#  local_config="$PWD/$config_file_name"
#
#  if [ -f "$local_config" ]; then
#    CONFIG=$local_config
#    types=($(jq -r '.types[]' "$CONFIG"))
#  else
    types=('build ci docs feat fix perf refactor style test chore')
#  fi
}

# build the regex pattern based on the config file
function build_regex() {
  set_config_values

  regexp="^[.0-9]+$|"

  regexp="${regexp}^([Rr]evert|[Mm]erge):? )?.*$|^("

  for type in "${types[@]}"
  do
    regexp="${regexp}$type|"
  done

  regexp="${regexp%|})(\(.+\))?: "
}


# Print out a standard error message which explains
# how the commit message should be structured
function print_error() {
  commit_message=$1
  regular_expression=$2
  echo -e "\n\e[31m[Invalid Commit Message]"
  echo -e "------------------------\033[0m\e[0m"
  echo -e "Valid types: \e[36m${types[@]}\033[0m"
  echo -e "\e[37mRegex: \e[33m$regular_expression\033[0m"
  echo -e "\e[37mActual commit message: \e[33m\"$commit_message\"\033[0m"
  echo -e "\e[37mActual length: \e[33m$(echo $commit_message | wc -c)\033[0m\n"
}

# make sure jq is installed
#check_jq_exists_and_executable

# get the first line of the commit message
INPUT_FILE=$1
START_LINE=`head -n1 $INPUT_FILE`

build_regex

if [[ ! $START_LINE =~ $regexp ]]; then
  # commit message is invalid according to config - block commit
  print_error
  exit 1
fi
