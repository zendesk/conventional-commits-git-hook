#!/bin/bash

COMMIT_MSG_SCRIPT=$1

# docs feat fix perf refactor style test chore
allowed_commit_messages=("docs: updates some documentation" \
	"feat: implements a new feature" \
	"fix: correct typo in function" \
	"perf: improve perf" \
    "refactor: implement a refactor" \
    "style: make a style change" \
    "test(ui): add a new test" \
    "chore: complete a simple chore" \
    "dataset(kb): create dataset" \
    "Revert \"test: add a new test\" " \
    "Revert: \"refactor(labels): implement a refactor\" " \
    "revert: \"feat: implements a new feature\" " \
    "0.1.0")

disallowed_commit_messages=("implements a new feature" "")

TMPFILE=$(mktemp)
ERROR_FILE=$(mktemp)
COUNT=0
for allowed_commit_message in "${allowed_commit_messages[@]}"
do
    echo "$allowed_commit_message" > $TMPFILE
    $COMMIT_MSG_SCRIPT $TMPFILE
    # Track the number of failed tests
    if [[ "$?" != "0" ]]
    then
        COUNT=$(echo "$COUNT + 1" | bc -l)
        echo "---"
    fi
done

for disallowed_commit_message in "${disallowed_commit_messages[@]}"
do
    echo "$disallowed_commit_message" > $TMPFILE
    # Since it passed, there is no error to be seen.
    $COMMIT_MSG_SCRIPT $TMPFILE >> $TMPFILE
    $COMMIT_MSG_SCRIPT $TMPFILE >> $TMPFILE
    # Track the number of failed tests
    if [[ "$?" == "0" ]]
    then
        echo -e "Failed: $disallowed_commit_message" >> $ERROR_FILE
        COUNT=$(echo "$COUNT + 1" | bc -l)
    fi
done

# Print summary of the number of failed tests
cat $ERROR_FILE
if [[ $COUNT -eq 0 ]]
then
    echo -e "All tests passed!"
elif [[ $COUNT -eq 1 ]]
then
    echo -e "$COUNT test failed"
elif [[ $COUNT -gt 1 ]]
then
    echo -e "$COUNT tests failed"
fi 

# Cleanup
rm $TMPFILE
rm $ERROR_FILE
