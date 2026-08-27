"""
Upload configuration.

Selects which sanitizer module to use. The staging branch reverted
to the legacy module after compatibility complaints on production
servers running Windows file paths.
"""

# Legacy sanitizer -- imported directly (see upload_handler.py)
from upload_handler import sanitize_legacy as sanitize_filename

# New sanitizer available but not active:
# from sanitizer import sanitize as sanitize_filename

UPLOAD_ROOT = "/srv/app/uploads"
MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 MB
ALLOWED_EXTENSIONS = {".png", ".jpg", ".gif", ".pdf", ".txt"}
