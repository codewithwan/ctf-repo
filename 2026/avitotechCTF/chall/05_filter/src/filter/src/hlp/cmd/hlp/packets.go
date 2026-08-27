package main

import (
	"context"
	"fmt"
	"honeyleakprevention/internal/flow"
	"honeyleakprevention/internal/nfq"
	"io"
)

type Packets interface {
	Run(ctx context.Context) (<-chan flow.Packet, error)
	SetVerdictFor(packetID flow.PacketId, allow flow.Verdict) error

	io.Closer
}

func MakePackets(ctx context.Context, filename string) (Packets, error) {
	if filename == "" {
		if err := nfq.SetupFilewallRules(ctx, nfqueueNum, tcpPort); err != nil {
			return nil, fmt.Errorf("setup firewall rules: %w", err)
		}
		return nfq.NewQueue(nfqueueNum, 2000)
	} else {
		return nfq.NewPcap(filename)
	}
}
