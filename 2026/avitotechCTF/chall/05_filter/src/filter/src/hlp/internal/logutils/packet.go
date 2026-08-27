package logutils

import (
	"github.com/google/gopacket/layers"
	"github.com/rs/zerolog"
)

type tcpLayerMeta struct {
	*layers.TCP
}

func TcpLayerMeta(tcp *layers.TCP) tcpLayerMeta {
	return tcpLayerMeta{tcp}
}

func (t tcpLayerMeta) MarshalZerologObject(e *zerolog.Event) {
	flags := make([]byte, 0, 10)

	if t.FIN {
		flags = append(flags, 'F')
	}
	if t.SYN {
		flags = append(flags, 'S')
	}
	if t.RST {
		flags = append(flags, 'R')
	}
	if t.PSH {
		flags = append(flags, 'P')
	}
	if t.ACK {
		flags = append(flags, 'A')
	}
	if t.URG {
		flags = append(flags, 'U')
	}
	if t.ECE {
		flags = append(flags, 'E')
	}
	if t.CWR {
		flags = append(flags, 'C')
	}
	if t.NS {
		flags = append(flags, 'N')
	}

	e.Bytes("flags", flags)
	e.Int("plen", len(t.Payload))
}

func SliceToArrayUInt32[T any](s []T, get func(T) uint32) *zerolog.Array {
	arr := zerolog.Arr()
	for _, v := range s {
		arr = arr.Uint32(get(v))
	}
	return arr
}
