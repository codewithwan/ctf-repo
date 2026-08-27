package flow

import (
	"fmt"

	"github.com/google/gopacket"
	"github.com/rs/zerolog"
)

type FlowId struct {
	Net       gopacket.Flow
	Transport gopacket.Flow
}

func (f *FlowId) MarshalZerologObject(e *zerolog.Event) {
	e.Str("ip", f.Net.String())
	e.Str("tcp", f.Transport.String())
}

func (f *FlowId) String() string {
	return fmt.Sprintf("%s;%s", f.Net, f.Transport)
}
