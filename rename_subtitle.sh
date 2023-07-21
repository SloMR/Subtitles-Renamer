#!/bin/bash
set -euo pipefail

# Function to print usage
function usage() {
    echo "Usage: $0 <language> <folder_path>"
    echo "e.g. $0 ar /Movies/MyMovie"
    exit 1
}