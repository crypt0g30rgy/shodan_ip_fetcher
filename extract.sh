#!/bin/bash

# Check for input file
#if [ -z "$1" ]; then
#    echo "Usage: $0 <shodan_export.json>"
#    exit 1
#fi

# input_file="$1"

# Extract ip:port pairs, sort and remove duplicates
# jq -r '. | "\(.ip_str):\(.port)"' "$input_file" | sort -u


#!/bin/bash

# Check for input files
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <file1.json> [file2.json ...] or <dir/*.json>"
    exit 1
fi

# Temporary file to hold results
temp_file=$(mktemp)

# Process each file
for input_file in "$@"; do
    if [ -f "$input_file" ]; then
        jq -r '. | "\(.ip_str):\(.port)"' "$input_file" >> "$temp_file" 2>/dev/null
    else
        echo "Warning: Skipping '$input_file' (not a file)"
    fi
done

# Sort and remove duplicates
sort -u "$temp_file"

# Clean up
rm "$temp_file"
