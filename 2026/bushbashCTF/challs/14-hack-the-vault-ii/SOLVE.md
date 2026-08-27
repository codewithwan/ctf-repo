**Flag:** `bushbash{1nto-th3-bUsh-w3-Go}`

## TL;DR

Send 127 non-NUL bytes to make `printf("%s")` leak the password that was read immediately after the input buffer, then reconnect with that password.

## Find

`array` is split manually:

```c
char *buffer = &array[0];
char *password = &array[127];
```

The program writes `buffer[inputlen] = '\0'` before reading `password.txt`, then `fread(password, ...)` overwrites that terminator. With 127 bytes of input, `printf("password you entered: %s\n", buffer)` prints our input followed by the password.

## Solve

The leak returned:

```text
GNk1f:sH)7#uY9$1vpS5c~Z^I#&fe6*a
```

Submitting that password to the remote prints the flag.
