#!/bin/bash
set -euo pipefail

# Function to print usage
function usage() {
    echo "Usage: $0 <language> <folder_path>"
    echo "e.g. $0 ar /Movies/MyMovie"
    exit 1
}

# Check that the user has provided the correct number of arguments
if [ $# -lt 2 ]; then
    usage
fi

LANGUAGE=$1    # e.g. ar
FOLDER_PATH=$2 # e.g. /Movies/MyMovie

# Echo the command and then run it
function echo_then_run() {
    echo "$@"
    "$@"
}

# Check that the user has provided the correct arguments
function check_input() {
    if [[ -z "$FOLDER_PATH" ]]; then
        echo "Please provide a folder path as an argument"
        exit 1
    fi

    if [[ ! -d "$FOLDER_PATH" ]]; then
        echo "Folder does not exist"
        exit 1
    fi

    if [[ -z "$LANGUAGE" ]]; then
        echo "Please provide a language code as an argument"
        exit 1
    fi
}

# Rename all files in a folder that do not contain a language code in their name to include the language code
# e.g. MyMovie.srt -> MyMovie.ar.srt
function check_rename() {
    check_input
    echo "Renaming all files that do not contain '$LANGUAGE' in their name"

    SUFFIX="$LANGUAGE"
    find "$FOLDER_PATH" \( -name "*.srt" -o -name "*.ass" \) -type f | while read -r f; do
        if [[ $f != *"$LANGUAGE".srt && $f != *"$LANGUAGE".ass ]] && [[ -f $f ]]; then
            echo_then_run mv -- "$f" "${f%.*}.$SUFFIX.${f##*.}"
        fi
    done

    exit 0
}

check_rename
