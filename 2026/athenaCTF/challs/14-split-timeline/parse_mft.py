import struct

def parse_mft(file_path):
    with open(file_path, 'rb') as f:
        data = f.read()
    
    records = []
    record_size = 1024
    
    for idx in range(len(data) // record_size):
        rec_data = data[idx*record_size : (idx+1)*record_size]
        if not rec_data.startswith(b'FILE'):
            continue
        
        # Parse MFT Record Header
        magic, update_seq_offset, update_seq_size, log_seq, seq_num, link_count, attr_offset = struct.unpack(
            '<4sHHQHHH', rec_data[:22]
        )
        
        offset = attr_offset
        filename = None
        sync_data = None
        
        while offset < len(rec_data):
            attr_type = struct.unpack('<I', rec_data[offset:offset+4])[0]
            if attr_type == 0xffffffff:
                break
            
            attr_len = struct.unpack('<I', rec_data[offset+4:offset+8])[0]
            if attr_len == 0:
                break
                
            non_resident = rec_data[offset+8]
            name_len = rec_data[offset+9]
            name_offset = struct.unpack('<H', rec_data[offset+10:offset+12])[0]
            
            name = ""
            if name_len > 0:
                name_bytes = rec_data[offset+name_offset : offset+name_offset + name_len*2]
                name = name_bytes.decode('utf-16le', errors='ignore')
            
            # $FILE_NAME attribute (0x30)
            if attr_type == 0x30 and not non_resident:
                content_offset = struct.unpack('<H', rec_data[offset+20:offset+22])[0]
                fn_len = rec_data[offset+content_offset+64]
                fn_bytes = rec_data[offset+content_offset+66 : offset+content_offset+66 + fn_len*2]
                filename = fn_bytes.decode('utf-16le', errors='ignore')
            
            # $DATA attribute (0x80)
            if attr_type == 0x80:
                if not non_resident:
                    content_size = struct.unpack('<I', rec_data[offset+16:offset+20])[0]
                    content_offset = struct.unpack('<H', rec_data[offset+20:offset+22])[0]
                    content = rec_data[offset+content_offset : offset+content_offset+content_size]
                    if name == "sync":
                        sync_data = content
                else:
                    # Non-resident
                    pass
            
            offset += attr_len
            
        if filename:
            records.append({
                'record_index': idx,
                'filename': filename,
                'sync_data': sync_data
            })
            
    return records

records = parse_mft('mft.bin')
for r in records:
    if r['filename'].startswith('~df') or r['sync_data']:
        print(f"Record {r['record_index']}: Filename={r['filename']}, sync_data={r['sync_data'].hex() if r['sync_data'] else None}")
