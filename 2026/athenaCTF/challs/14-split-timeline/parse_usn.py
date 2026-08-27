import struct
from datetime import datetime, timedelta

def filetime_to_dt(ft):
    # Convert Windows FILETIME (100-nanosecond intervals since Jan 1, 1601) to python datetime
    try:
        return datetime(1601, 1, 1) + timedelta(microseconds=ft // 10)
    except Exception:
        return None

def parse_usn(file_path):
    with open(file_path, 'rb') as f:
        data = f.read()
    
    offset = 0
    records = []
    
    while offset < len(data):
        # Read RecordLength first
        if offset + 4 > len(data):
            break
        rec_len = struct.unpack('<I', data[offset:offset+4])[0]
        if rec_len == 0:
            # Skip alignment padding (zeros)
            offset += 4
            continue
            
        if offset + rec_len > len(data):
            break
            
        rec_data = data[offset : offset + rec_len]
        
        # Parse version
        major, minor = struct.unpack('<HH', rec_data[4:8])
        if major == 2:
            file_ref, parent_ref, usn, timestamp, reason = struct.unpack('<QQQQI', rec_data[8:44])
            fn_len, fn_offset = struct.unpack('<HH', rec_data[56:60])
            fn_bytes = rec_data[fn_offset : fn_offset + fn_len]
            filename = fn_bytes.decode('utf-16le', errors='ignore')
            
            # Map reason bits
            reasons = []
            if reason & 0x00000001: reasons.append("DATA_OVERWRITE")
            if reason & 0x00000002: reasons.append("DATA_EXTEND")
            if reason & 0x00000004: reasons.append("DATA_TRUNCATION")
            if reason & 0x00000100: reasons.append("NAMED_DATA_OVERWRITE")
            if reason & 0x00000200: reasons.append("NAMED_DATA_EXTEND")
            if reason & 0x00000400: reasons.append("NAMED_DATA_TRUNCATION")
            if reason & 0x00000010: reasons.append("DIRECTORY_CREATION")
            if reason & 0x00000100: reasons.append("FILE_CREATION") # wait, 0x100 is named data overwrite in V2 usually. File creation is 0x00000100? No, 0x00000100 is FILE_CREATE. Let's check reason flags.
            # Common USN Reason flags:
            # 0x00000100: USN_REASON_FILE_CREATE
            # 0x00000200: USN_REASON_FILE_DELETE
            # 0x00008000: USN_REASON_CLOSE
            
            dt = filetime_to_dt(timestamp)
            records.append({
                'filename': filename,
                'timestamp': dt,
                'usn': usn,
                'reason': reason,
                'reason_str': ", ".join(reasons)
            })
        offset += rec_len
        
    return records

records = parse_usn('usnjrnl.bin')
for r in records:
    if r['filename'].startswith('~df'):
        print(f"USN={r['usn']}, Time={r['timestamp']}, Filename={r['filename']}, Reason={hex(r['reason'])}")
