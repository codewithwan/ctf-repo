# Upload Lantern

A file upload feature was exported from a staging branch after a sanitization change. Multiple modules handle filename sanitization -- trace which one ships in production and find the gap.

## Files

- `upload_handler.py` -- the upload handler and its embedded legacy sanitizer
- `sanitizer.py` -- a newer, more comprehensive sanitizer module
- `config.py` -- configuration that selects which sanitizer is active
- `tree.txt` -- text snapshot of the server directory tree

## Goal

Determine which sanitizer is actually used at runtime, identify its weakness, and
reason about the server layout to figure out what an attacker could reach.

A live instance of the staging service is provided. It serves previously uploaded
files back to you:

- `GET /view?name=<filename>` returns the contents of a stored upload.
- `POST /upload?name=<filename>` stores a file (raw bytes in the body).

Use the source and `tree.txt` to work out a `name` that reaches the private flag,
then read it through the running service.

Submit the flag in `athena{...}` format.