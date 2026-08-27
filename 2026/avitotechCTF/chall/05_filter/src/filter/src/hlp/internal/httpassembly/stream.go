package httpassembly

import (
	"honeyleakprevention/internal/checker"
	"honeyleakprevention/internal/flow"

	"github.com/google/gopacket"
	"github.com/google/gopacket/tcpassembly"
	"github.com/rs/zerolog/log"
)

type HttpStreamFactory struct {
	Verdict flow.VerdictHandler
}

type HttpStream struct {
	flowId        flow.FlowId
	verdict       flow.VerdictHandler
	isUnderReview bool

	currentResponce responce
}

func (f *HttpStreamFactory) New(net, transport gopacket.Flow) tcpassembly.Stream {
	hstream := &HttpStream{
		flowId: flow.FlowId{
			Net:       net,
			Transport: transport,
		},
		verdict:       f.Verdict,
		isUnderReview: false,
	}

	log.Debug().
		Object("flow", &hstream.flowId).
		Msg("new flow")

	return hstream
}

func (h *HttpStream) Reassembled(reassembly []tcpassembly.Reassembly) {
	for _, p := range reassembly {
		if !h.isUnderReview && len(p.Bytes) > 0 {
			h.verdict.FlowUnderAudit(h.flowId)
			h.isUnderReview = true
		}

		id := flow.IdFromFakeTime(p.Seen)

		log.Debug().
			Uint32("id", id.Num).
			Object("flow", &h.flowId).
			Bytes("data", p.Bytes).
			Msg("new packet")

		found := h.processResponce(p.Bytes)

		if found {
			h.verdict.Detect(h.flowId, id)
		} else {
			h.verdict.PassPacket(h.flowId, id)
		}
	}
}

func (h *HttpStream) ReassemblyComplete() {
	log.Info().Object("flow", &h.flowId).Msg("stream done")
}

func (h *HttpStream) processResponce(packet []byte) bool {
	h.currentResponce.Add(packet)
	body, headers, isComplite, err := h.currentResponce.Reparse()
	if isComplite {
		defer h.currentResponce.Reset()
	}

	if err != nil {
		log.Warn().
			Err(err).
			Object("flow", &h.flowId).
			Msg("bad response")
		return false
	}

	return checker.Check(body) || checker.CheckValues(headers)
}
