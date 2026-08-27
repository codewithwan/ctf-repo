package flow

import (
	"slices"
	"sync"
	"time"
)

type VerdictHandler interface {
	FlowUnderAudit(FlowId)
	FlowNotInterected(FlowId)

	PassPacket(FlowId, PacketId)
	Detect(FlowId, PacketId)
}

type VerdictCallback = func(id PacketId, verdict Verdict) error

type VerdictStore struct {
	mu sync.Mutex

	flows map[FlowId]*FlowPackets

	setVerdict VerdictCallback
}

type pending struct {
	registered time.Time
	id         PacketId
}

type FlowPackets struct {
	State Verdict

	pendings []pending
}

func NewStore(setVerdict VerdictCallback) *VerdictStore {
	return &VerdictStore{
		mu:         sync.Mutex{},
		flows:      make(map[FlowId]*FlowPackets),
		setVerdict: setVerdict,
	}
}

func (v *VerdictStore) GetBeforeThen(point time.Time) map[Verdict][]PacketId {
	v.mu.Lock()
	defer v.mu.Unlock()

	result := make(map[Verdict][]PacketId)

	for _, v := range v.flows {
		v.pendings = slices.DeleteFunc(v.pendings, func(val pending) bool {
			if val.registered.Before(point) {
				result[v.State] = append(result[v.State], val.id)
				return true
			}
			return false
		})
	}

	return result
}

func (v *VerdictStore) Put(flow FlowId, packet PacketId) Verdict {
	v.mu.Lock()
	defer v.mu.Unlock()

	if _, ok := v.flows[flow]; !ok {
		v.flows[flow] = &FlowPackets{
			State:    Later,
			pendings: make([]pending, 0, 10),
		}
	}

	v.flows[flow].pendings = append(v.flows[flow].pendings, pending{
		registered: time.Now(),
		id:         packet,
	})

	return v.flows[flow].State
}

func (v *VerdictStore) FlowUnderAudit(flow FlowId) {
	v.mu.Lock()
	defer v.mu.Unlock()

	if _, ok := v.flows[flow]; ok {
		return
	}

	v.flows[flow] = &FlowPackets{
		State:    Later,
		pendings: make([]pending, 0, 10),
	}
}

func (v *VerdictStore) FlowNotInterected(flow FlowId) {
	v.mu.Lock()
	defer v.mu.Unlock()

	delete(v.flows, flow)
}

func (v *VerdictStore) PassPacket(flow FlowId, packet PacketId) {
	v.mu.Lock()
	defer v.mu.Unlock()

	verdict := Accept

	flowVerdict := v.flows[flow].State
	if flowVerdict == Drop {
		verdict = Drop
	}

	v.doVerdict(flow, packet, verdict)
}

func (v *VerdictStore) Detect(flow FlowId, packet PacketId) {
	v.mu.Lock()
	defer v.mu.Unlock()

	v.doVerdict(flow, packet, Drop)
	v.flows[flow].State = Drop
}

func (v *VerdictStore) doVerdict(flow FlowId, packet PacketId, verdict Verdict) {
	v.flows[flow].pendings = slices.DeleteFunc(v.flows[flow].pendings, func(p pending) bool {
		if p.id.Num <= packet.Num {
			v.setVerdict(p.id, verdict)
			return true
		}
		return false
	})
}
