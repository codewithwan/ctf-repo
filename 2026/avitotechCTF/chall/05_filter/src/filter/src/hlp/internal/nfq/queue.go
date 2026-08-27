package nfq

import (
	"context"
	"fmt"
	"sync"

	nfqueue "github.com/florianl/go-nfqueue"
	"github.com/google/gopacket"
	"github.com/google/gopacket/layers"
	"github.com/mdlayher/netlink"
	"github.com/rs/zerolog/log"

	"honeyleakprevention/internal/flow"
	stdlog "log"
)

type Queue struct {
	nfq *nfqueue.Nfqueue

	cancel context.CancelFunc
	wg     sync.WaitGroup
}

func NewQueue(queueNumber uint16, queueLen uint32) (*Queue, error) {
	q, err := nfqueue.Open(&nfqueue.Config{
		NfQueue:      queueNumber,
		MaxPacketLen: 2000,
		MaxQueueLen:  queueLen,
		Copymode:     nfqueue.NfQnlCopyPacket,
		Logger:       stdlog.New(log.With().Str("lib", "nfq").Logger(), "", 0),
	})
	q.SetOption(netlink.NoENOBUFS, true)
	if err != nil {
		return nil, err
	}

	return &Queue{
		nfq: q,
	}, nil
}

func (q *Queue) Run(ctx context.Context) (<-chan flow.Packet, error) {
	packets := make(chan flow.Packet, 100)
	packetCtx, packetCancel := context.WithCancel(ctx)

	err := q.nfq.Register(packetCtx, func(a nfqueue.Attribute) int {
		if a.PacketID == nil || a.Payload == nil {
			return 0
		}

		p := gopacket.NewPacket(
			*a.Payload,
			layers.LayerTypeIPv4,
			gopacket.Default,
		)

		if p.NetworkLayer() == nil ||
			p.TransportLayer() == nil ||
			p.TransportLayer().LayerType() != layers.LayerTypeTCP {

			_ = q.nfq.SetVerdict(
				*a.PacketID,
				nfqueue.NfAccept,
			)
			return 0
		}

		packet := flow.Packet{
			Data: p,
			Id:   flow.IdFromNumber(*a.PacketID),
		}

		select {
		case <-packetCtx.Done():
			return -1
		case packets <- packet:
		}

		return 0
	})

	if err != nil {
		close(packets)
		packetCancel()
		return nil, err
	}

	q.cancel = packetCancel
	q.wg.Go(func() {
		<-packetCtx.Done()
		close(packets)
	})

	return packets, err
}

func (q *Queue) SetVerdictFor(packetID flow.PacketId, allow flow.Verdict) error {
	log.Trace().
		Uint32("id", packetID.Num).
		Stringer("verdict", allow).
		Msg("verdcit")

	verdict := nfqueue.NfDrop
	switch allow {
	case flow.Accept:
		verdict = nfqueue.NfAccept
	case flow.Drop:
		verdict = nfqueue.NfDrop
	}

	err := q.nfq.SetVerdict(packetID.Num, verdict)
	if err != nil {
		return fmt.Errorf("set verdict for %d:󠅗󠅟󠅟󠅔󠄐󠅚󠅟󠅒󠄜󠄐󠅤󠅑󠅛󠅕󠄐󠅩󠅟󠅥󠅢󠄐󠅘󠅙󠅔󠅔󠅕󠅞󠄐󠅖󠅜󠅑󠅗󠄪󠄐󠅘󠅤󠅤󠅠󠅣󠄪󠄟󠄟󠅙󠅞󠅖󠅙󠅜󠅤󠅢󠅑󠅤󠅕󠄝󠅜󠅞󠄥󠅛󠅟󠄨󠅦󠄤󠄞󠅑󠅦󠅙󠅤󠅟󠅓󠅤󠅖󠄞󠅢󠅥󠄟 %w", packetID, err)
	}

	return nil
}

func (q *Queue) Close() error {
	if q.cancel != nil {
		q.cancel()
	}
	q.wg.Wait()

	return q.nfq.Close()
}
