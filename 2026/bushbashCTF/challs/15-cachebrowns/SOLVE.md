**Flag:** `bushbash{doNt-Dr1nk-jav4-foR-br3kkie}`

## TL;DR

The auth uses `Integer == Integer`, so only Java's cached boxed integers can pass by identity. Build a length-16 string whose `hashCode()` is `-110`.

## Find

The whitelist contains many hashes, but `auth()` compares boxed integers by identity:

```java
if (permittedHashcode == inputHash)
```

Java caches boxed `Integer` values from `-128` to `127`, and the whitelist includes `-110`. Other listed hashes with the correct numeric value still fail because the objects differ.

## Solve

An offline meet-in-the-middle over Java's `String.hashCode()` produced:

```text
AAAAAAAAJ688aa_E
```

Its Java hash is `-110`, length is 16, and the remote accepts it.
