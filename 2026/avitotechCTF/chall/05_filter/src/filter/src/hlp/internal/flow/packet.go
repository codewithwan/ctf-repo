package flow

import (
	"time"

	"github.com/google/gopacket"
)

type Packet struct {
	Data gopacket.Packet
	Id   PacketId
}

type PacketId struct {
	Num uint32
}

func IdFromNumber(num uint32) PacketId {
	return PacketId{
		Num: num,
	}
}

func IdFromFakeTime(t time.Time) PacketId {
	return PacketId{
		Num: uint32(t.UnixMicro()),
	}
}

func (i PacketId) AsFakeTime() time.Time {
	return time.UnixMicro(int64(i.Num))
}
