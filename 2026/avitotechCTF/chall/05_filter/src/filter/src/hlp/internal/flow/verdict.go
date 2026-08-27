package flow

type Verdict int

const (
	Drop Verdict = iota
	Accept
	Later
	Unknow
)

func (v Verdict) String() string {
	switch v {
	case Accept:
		return "accept"
	case Drop:
		return "drop"
	case Later:
		return "later"
	case Unknow:
		return "unknow"
	}
	return "???"
}
