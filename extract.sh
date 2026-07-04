#!/bin/env bash

# Check for input files
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <file1.json|file1.json.gz> [file2.json|file2.json.gz ...]"
    exit 1
fi

# Temporary file to hold results
temp_file=$(mktemp)

# Process each file
for input_file in "$@"; do
    if [ ! -f "$input_file" ]; then
        echo "Warning: Skipping '$input_file' (not a file)"
        continue
    fi

    if [[ "$input_file" == *.gz ]]; then
        # Read compressed JSON without modifying the original file
        gunzip -c "$input_file" | \
            jq -r '"\(.ip_str):\(.port)"' >> "$temp_file" 2>/dev/null
    else
        jq -r '"\(.ip_str):\(.port)"' "$input_file" >> "$temp_file" 2>/dev/null
    fi
done

# Sort and remove duplicates
sort -u "$temp_file"

# Clean up
rm -f "$temp_file"
