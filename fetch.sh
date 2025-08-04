#!/bin/bash

INPUT_FILE="200.txt"

while IFS= read -r url; do
    # Trim leading & trailing whitespace from $url
    url="$(echo -e "${url}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    
    [[ -z "$url" ]] && continue

    ip=$(echo "$url" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')
    [[ -z "$ip" ]] && { echo "[!] Skipping malformed URL: $url"; continue; }

    echo "[*] Fetching: $url"

    curl_cmd="curl -kvv --proxy http://172.30.224.1:8080 '$url' -o ${ip}.env"

    echo "[>] Running: $curl_cmd"

    eval $curl_cmd

    echo "[+] Saved to ${ip}.env"
done < "$INPUT_FILE"
