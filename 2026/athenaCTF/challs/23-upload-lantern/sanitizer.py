"""
Sanitizer v2 - comprehensive path sanitization.

Replaces the legacy sanitize_filename() with a multi-layer approach:
- Strips null bytes
- Removes both slash types (forward and backward)
- Collapses traversal components
- Rejects empty or dot-only names
"""


def sanitize(filename: str) -> str:
    """Production sanitizer. Returns a safe basename or 'upload.bin'."""
    if not filename:
        return "upload.bin"

    # Layer 1: null byte stripping
    cleaned = filename.replace("\x00", "")

    # Layer 2: remove all path separators
    cleaned = cleaned.replace("/", "").replace("\\", "")

    # Layer 3: collapse traversal components
    while ".." in cleaned:
        cleaned = cleaned.replace("..", "")

    # Layer 4: collapse redundant dots
    cleaned = cleaned.lstrip(".")

    # Layer 5: strip whitespace
    cleaned = cleaned.strip()

    return cleaned or "upload.bin"
