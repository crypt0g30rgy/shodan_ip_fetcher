#3Shodan IP Fetcher
A simple Python script to fetch SSL-enabled IPs related to a specific host using the Shodan API.

## Description
This script utilizes the Shodan API to search for SSL-enabled hosts related to a specified domain. It then retrieves the IP addresses of these hosts and dumps them into a text file.

## Features
- Fetch SSL-enabled IPs related to a specific host using the ssl dork
- Customizable search limit
- Command-line interface for easy usage
## Usage
1. Clone the repository:

```bash
git clone https://github.com/crypt0g30rgy/shodan_ip_fetcher.git
```
2. Install the required dependencies:

```bash
pip install shodan
```
3. Run the script with your Shodan API key, output file path, and target host:

```bash
python shodan_ip_fetcher.py -k <api_key> -o <output_file> -h <target_host> [--limit LIMIT]
```

Replace <api_key>, <output_file>, and <target_host> with your Shodan API key, output file path, and the target host (e.g., example.com) respectively. You can also optionally specify the --limit argument to set the number of results (default is 200).

## Requirements
- Python 3
- Shodan API key
