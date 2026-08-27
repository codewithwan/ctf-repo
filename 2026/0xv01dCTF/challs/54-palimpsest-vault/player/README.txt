Palimpsest Vault
================

Category: Web
Difficulty: Very Hard
Author: 0x4sh
Suggested value: 500

The vault signs viewing tickets for public folios. The clerk says it checks the
shelf path before stamping the ticket. The renderer says old ink needs more
patience than that.

Goal:

  Recover the uncatalogued folio.

Service:

  http://CHALLENGE_HOST:21004/

Notes:

  - The private shelf is not directly routable.
  - Tickets are real HMAC tickets; do not try to brute-force the signing key.
  - The interesting bug is in how different parts of the vault read the same
    shelf path.
