from typing import List, Dict


def snakeToCamel(snake_str: str) -> str:
    """Convert a snake_case string to camelCase."""
    parts = snake_str.split("_")
    return parts[0] + "".join(word.capitalize() for word in parts[1:])


def convertListKeyToCamel(data: List[Dict]) -> List[Dict]:
    """Convert all keys in a list of dictionaries from snake_case to camelCase."""
    return [{snakeToCamel(k): v for k, v in item.items()} for item in data]
