#! /usr/bin/env python3
import os
import json
import requests

GHUSER = os.getenv('GITHUB_USER')
url = f'https://api.github.com/users/{GHUSER}/events'


def retrieve_events(url):
    """Download JSON event data from url and return it as a Python object."""
    data = requests.get(url).text
    return json.loads(data)


def print_events(events, n=5):
    """Print the type and repo name for the first n events."""
    for x in events[:n]:
        event = x['type'] + ' :: ' + x['repo']['name']
        print(event)


def main():
    """Fetch and print recent GitHub events for GHUSER."""
    print(GHUSER)
    print(url)
    events = retrieve_events(url)
    print_events(events)


if __name__ == "__main__":
    main()