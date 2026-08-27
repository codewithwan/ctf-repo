package nfq

import (
	"context"
	"honeyleakprevention/internal/flow"
	"os"

	"github.com/google/gopacket"
	"github.com/google/gopacket/pcapgo"
	"github.com/rs/zerolog/log"
)

type Pcap struct {
	file *os.File
}

func NewPcap(filename string) (*Pcap, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}

	return &Pcap{
		file: file,
	}, err
}

func (q *Pcap) Run(ctx context.Context) (<-chan flow.Packet, error) {
	reader, err := pcapgo.NewReader(q.file)
	if err != nil {
		return nil, err
	}

	packetSource := gopacket.NewPacketSource(reader, reader.LinkType())
	packets := make(chan flow.Packet)

	go func() {
		cnt := uint32(0)

	loop:
		for p := range packetSource.Packets() {
			cnt += 1

			packet := flow.Packet{
				Data: p,
				Id:   flow.IdFromNumber(cnt),
			}

			select {
			case <-ctx.Done():
				break loop
			case packets <- packet:
			}
		}

		close(packets)
	}()

	return packets, nil
}
func (q *Pcap) SetVerdictFor(packetID flow.PacketId, allow flow.Verdict) error {
	log.Debug().
		Uint32("id", packetID.Num).
		Stringer("verdict", allow).
		Msg("verdcit")
	return nil
}

func (q *Pcap) Close() error {
	return q.file.Close()
}
