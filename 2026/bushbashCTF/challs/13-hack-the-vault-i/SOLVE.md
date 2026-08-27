**Flag:** `bushbash{th1s-is-just-th3-beginning!}`

## TL;DR

The stripped ELF contains the password in `.rodata`; sending it to the remote makes the service print `flag.txt`.

## Find

`strings vault` exposes the password:

```text
th3M0ssM4ni5h3re,y0uc4ntcatchm3
```

The binary also says the local run will not have `flag.txt`, so the password must be used against the netcat service.

## Solve

```bash
printf 'th3M0ssM4ni5h3re,y0uc4ntcatchm3\n' | nc 34.40.133.67 7776
```

The remote prints the verified flag.
