# Talib — progress

## Blob decode
Blob (dari prompt, antara "Video:" dan "Submit") = ASCII85:
`BQS?8F#ks-GB\6`H#IhIF^eo7@rH3;G@>T'BKpZ':01;:GVh!HAQ!.fF?MN>Er`

```python
import base64
base64.a85decode("BQS?8F#ks-GB\\6`H#IhIF^eo7@rH3;G@>T'BKpZ':01;:GVh!HAQ!.fF?MN>Er")
# -> https://www.youtube.com/watch?v=NWQwx4-MeRg&t=65s
```

## Video
https://www.youtube.com/watch?v=NWQwx4-MeRg  (timestamp t=65s)

## TODO
- Identify LOCATION (English name) + DATE (YYYY-MM-DD) dari video
- Submit: athena{location name_YYYY-MM-DD}

## Video analysis (t=65s)
- Video: AFP News Agency — "Afghanistan, 2009 : a year both deadly and decisive"
- Frame @65s: AFP news package. Right-side "Text" panel dateline reads:
  > "2009 deadliest year for foreign troops in Afghanistan.
  >  KABUL, August 25, 2009 (AFP)"
- Place = Kabul ; Date = 2009-08-25

## Candidate flag
athena{Kabul_2009-08-25}

(alt lokasi kalau salah: Helmand — layar juga nampilin peta "Operation Khanjar / HELMAND")
