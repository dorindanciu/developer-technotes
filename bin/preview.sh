#!/bin/sh

# Function to assert the validity of a .docc file.
# Arguments:
#   - $1: The file to be checked
# Exit codes:
#   - 1: Invalid file provided
assert_docc_file() {
    local docc_file="$1"
    if [[ ! -f "$docc_file" ]] && [[ "$docc_file" != *.docc ]]; then
        echo "Invalid file. Please provide a .docc file."
        exit 1
    fi
}

# Function to assert the validity of a directory.
# Arguments:
#   - $1: The directory to be checked
# Exit codes:
#   - 1: Invalid directory provided
assert_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "Invalid directory. Please provide a valid directory path."
        exit 1
    fi
}

# Function to convert a DocC file to HTML using docc.
#
# Arguments:
#   - $1: The path to the DocC file to be converted
#   - $2: The output directory where the converted HTML files will be saved
convert() {
    local docc_file="$1"
    local output_dir="$2"

    # Assert the validity of the provided arguments
    assert_docc_file "$docc_file"
    assert_dir "$output_dir"

    # Convert the DocC file to HTML
    xcrun docc convert \
        --experimental-enable-custom-templates \
        --output-path "$output_dir" \
        "$docc_file"
}

# Function to bootstrap a local server in the specified directory.
# Arguments:
#   - $1: The directory path where the server should be started.
# Exit codes:
#   - 1: Invalid directory provided
bootstrap() {
    local dir="$1"

    # Assert the validity of the provided arguments
    assert_dir "$dir"

    # Print the URL to be used to preview the documentation
    echo "Open http://localhost:8000/documentation/ to experience a local preview in your browser."

    # Start a Ruby HTTP server on port 8000
    ruby -run -e httpd -- "$dir" -p 8000
}

# This function converts the provided DocC file to HTML
# and starts a local server to preview the documentation.
#
# Arguments:
#   - $1: The path to the DocC file to be converted
#   - $2: The output directory where the converted HTML files will be saved
preview() {
    local docc_file="$1"
    local output_dir="$2"

    # Assert the validity of the provided arguments
    assert_docc_file "$docc_file"
    assert_dir "$output_dir"

    # Convert the docc file to HTML
    convert "$docc_file" "$output_dir"

    # Bootstrap a local server
    bootstrap "$output_dir"
}

main() {
    local docc_file="./Technotes/Documentation.docc"
    local output_dir="./.build/output"

    # Create the output directory if it does not exist
    mkdir -p $output_dir

    # Generate a local preview of the documentation
    preview "$docc_file" "$output_dir"
}

# By specifying the set -e shell option, this script will exit immediately if it
# encounters an error. More information about this option can be found here:
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -euo pipefail

# Pretty print DocC JSON output so that it can be consistently diffed between commits.
export DOCC_JSON_PRETTYPRINT="YES"

# Run the main function
main
