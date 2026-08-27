"""
File upload handler -- staging branch.

This module contains the upload logic and the legacy sanitizer
that was re-enabled after the v2 sanitizer caused path issues
on the production Windows servers.
"""

from pathlib import Path

from config import UPLOAD_ROOT, MAX_FILE_SIZE


def sanitize_legacy(filename: str) -> str:
    """
    Legacy sanitizer. Strips forward slashes only.

    NOTE: Kept for backward compatibility. The v2 sanitizer
    in sanitizer.py handles both slash types but was reverted
    after deployment failures on Windows.
    """
    cleaned = filename.replace("/", "")
    cleaned = cleaned.strip()
    return cleaned or "upload.bin"


def save_upload(filename: str, content: bytes) -> Path:
    """Save an uploaded file to the uploads directory."""
    if len(content) > MAX_FILE_SIZE:
        raise ValueError("File too large")

    safe_name = sanitize_legacy(filename)
    destination = Path(UPLOAD_ROOT) / safe_name
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_bytes(content)
    return destination


def preview_path(filename: str) -> str:
    """Return the resolved path for a given upload filename."""
    safe_name = sanitize_legacy(filename)
    return str((Path(UPLOAD_ROOT) / safe_name).resolve())
