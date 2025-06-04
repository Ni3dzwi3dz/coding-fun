from pathlib import Path
import httpx
import logging

log = logging.getLogger(__name__)


BASE_URL = "https://www.codewars.com/api/v1/code-challenges/"


def get_kata_url(kata_id: str) -> str:
    """
    Constructs the URL for a specific CodeWars kata.

    Args:
        kata_id (str): The ID of the kata.

    Returns:
        str: The full URL to the kata.
    """
    return f"{BASE_URL}{kata_id}"

def get_kata_dict(kata_id: str) -> dict:
    '''
    Fetches the HTML content of a specific CodeWars kata.
    Args:
        kata_id (str): The ID of the kata.'''
    url = get_kata_url(kata_id)
    response = httpx.get(url)
    if response.status_code == 200:
        return response.json()
    else:
        log.error(f"Failed to fetch kata {kata_id} from {url}: {response.status_code} {response.reason_phrase}")
        raise Exception(f"Failed to fetch kata {kata_id}: {response.status_code} {response.reason_phrase}")

def get_kata_path(name: str, rank: int) -> Path:
    return Path(f"codewars/{abs(rank)}kyu/{name.replace(' ', '_').replace('-','_').lower()}")