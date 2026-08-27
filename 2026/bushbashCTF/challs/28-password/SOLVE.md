# password

Flag: `bushbash{i_l0v3_C0bs}`

The server output is not raw text. It is COBS framed data:

```text
0d 50 6c 65 61 73 65 20 4c 6f 67 69 6e 00
```

The leading `0d` is the COBS length code for `Please Login`, and `00` is the
sentinel. Sending raw `admin` causes the service to complain that no sentinel
was received.

Encode the known credentials as COBS frames:

```text
admin    -> 06 61 64 6d 69 6e 00
password -> 09 70 61 73 73 77 6f 72 64 00
```

The service then returns:

```text
Your flag is bushbash{i_l0v3_C0bs}
```
