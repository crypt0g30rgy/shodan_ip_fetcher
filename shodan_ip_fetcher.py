import shodan
import argparse

def search_shodan(api_key, output_file, target_host, limit=200):
    try:
        # Initialize the Shodan API object
        api = shodan.Shodan(api_key)

        # Perform the search
        query = f'ssl:"{target_host}"'
        results = api.search(query, limit=limit)

        # Dump IPs to the output file
        with open(output_file, 'w') as file:
            for result in results['matches']:
                ip = result['ip_str']
                file.write(ip + '\n')

        print(f"Found {len(results['matches'])} IPs related to '{target_host}'.")
        print(f"IPs dumped to {output_file}")

    except shodan.APIError as e:
        print('Error: %s' % e)

def main():
    parser = argparse.ArgumentParser(description="Shodan IP Fetcher")
    parser.add_argument("-k", "--api_key", help="Your Shodan API key", required=True)
    parser.add_argument("-o", "--output_file", help="Output file to store the IPs", required=True)
    parser.add_argument("-h", "--target_host", help="Target host to search for", required=True)
    parser.add_argument("--limit", type=int, default=200, help="Limit the number of results (default: 200)")
    args = parser.parse_args()

    search_shodan(args.api_key, args.output_file, args.target_host, args.limit)

if __name__ == '__main__':
    main()
