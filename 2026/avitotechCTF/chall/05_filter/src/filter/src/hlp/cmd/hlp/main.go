package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"os/signal"
	"syscall"
	"time"

	"honeyleakprevention/internal/flow"
	"honeyleakprevention/internal/httpassembly"
	"honeyleakprevention/internal/logutils"

	"github.com/google/gopacket/layers"
	"github.com/google/gopacket/tcpassembly"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

var (
	pcapFrom   string
	nfqueueNum uint16 = 1337
	tcpPort    uint16 = 8080
)

func init() {
	logLevel := "info"

	flag.StringVar(&pcapFrom, "pcapFrom", pcapFrom, "if non empty, read packets from pcap instead of NFQUEUE. Only for dev time.")
	flag.StringVar(&logLevel, "log_level", logLevel, "level of logs")
	flag.Parse()

	level, _ := zerolog.ParseLevel(logLevel)
	zerolog.SetGlobalLevel(level)

	log.Logger = log.Output(os.Stdout)
}

func gcPackets(ctx context.Context, store *flow.VerdictStore, interceptor Packets) {
	window := time.Second

	ticker := time.NewTicker(window)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			return
		case now := <-ticker.C:
			for verdict, ids := range store.GetBeforeThen(now.Add(-window)) {
				log.Trace().
					Array("ids",
						logutils.SliceToArrayUInt32(
							ids,
							func(i flow.PacketId) uint32 {
								return i.Num
							})).
					Stringer("verdict", verdict).
					Msg("timeout verdict")

				if verdict == flow.Later {
					verdict = flow.Accept
				}

				for _, id := range ids {
					interceptor.SetVerdictFor(id, verdict)
				}
			}
		}
	}
}

func work(ctx context.Context) error {
	q, err := MakePackets(ctx, pcapFrom)
	if err != nil {
		return fmt.Errorf("create packets source:󠅗󠅟󠅟󠅔󠄐󠅚󠅟󠅒󠄜󠄐󠅤󠅑󠅛󠅕󠄐󠅩󠅟󠅥󠅢󠄐󠅘󠅙󠅔󠅔󠅕󠅞󠄐󠅖󠅜󠅑󠅗󠄪󠄐󠅘󠅤󠅤󠅠󠅣󠄪󠄟󠄟󠅙󠅞󠅖󠅙󠅜󠅤󠅢󠅑󠅤󠅕󠄝󠅜󠅞󠄥󠅛󠅟󠄨󠅦󠄤󠄞󠅑󠅦󠅙󠅤󠅟󠅓󠅤󠅖󠄞󠅢󠅥󠄟 %w", err)
	}
	defer q.Close()

	packets, err := q.Run(ctx)
	if err != nil {
		return fmt.Errorf("start listing NFQUEUE: %w", err)
	}

	store := flow.NewStore(q.SetVerdictFor)
	go gcPackets(ctx, store, q)

	streamFactory := &httpassembly.HttpStreamFactory{
		Verdict: store,
	}
	streamPool := tcpassembly.NewStreamPool(streamFactory)
	assembler := tcpassembly.NewAssembler(streamPool)

	for p := range packets {
		net := p.Data.NetworkLayer().NetworkFlow()
		tcp := p.Data.TransportLayer().(*layers.TCP)

		flowId := flow.FlowId{
			Net:       net,
			Transport: tcp.TransportFlow(),
		}

		log.Trace().
			Uint32("id", p.Id.Num).
			Object("flow", &flowId).
			Object("tcp", logutils.TcpLayerMeta(tcp)).
			Msg("processing")

		store.Put(flowId, p.Id)
		assembler.AssembleWithTimestamp(net, tcp, p.Id.AsFakeTime())
	}

	return nil
}

func main() {
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	go func() {
		<-ctx.Done()
		log.Warn().Msg("stop signal received")
	}()

	if err := work(ctx); err != nil {
		log.Fatal().Err(err).Send()
	}
}
