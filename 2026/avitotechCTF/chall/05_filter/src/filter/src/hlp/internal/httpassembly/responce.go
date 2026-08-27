package httpassembly

import (
	"bufio"
	"bytes"
	"errors"
	"fmt"
	"io"
	"net/http"
)

var (
	fullResponceMaxSize = 3072
)

type responce struct {
	fullResponce []byte
}

func (r *responce) Add(packet []byte) {
	if len(r.fullResponce) >= fullResponceMaxSize {
		r.fullResponce = r.fullResponce[:0]
	}

	r.fullResponce = append(r.fullResponce, packet...)
}

func (r *responce) Reparse() ([]byte, []http.Header, bool, error) {
	reader := bufio.NewReader(bytes.NewReader(r.fullResponce))
	resp, err := http.ReadResponse(reader, nil)
	if err != nil {
		return nil, nil, false, fmt.Errorf("parse response: %w", err)
	}
	defer resp.Body.Close()

	b := &bytes.Buffer{}
	_, err = b.ReadFrom(resp.Body)

	isComplite := (err == nil)
	if errors.Is(err, io.ErrUnexpectedEOF) {
		err = nil
	}

	headers := []http.Header{
		resp.Header,
		resp.Trailer,
	}

	if isComplite {
		hint := len(resp.Header.Values("Trailer"))
		headers = append(headers, r.TrailerNonChanked(reader, hint))
	}

	return b.Bytes(), headers, isComplite, err
}

func (r *responce) TrailerNonChanked(reader *bufio.Reader, trailerHint int) http.Header {
	trailer := make(http.Header, trailerHint)
	for {
		line, _, err := reader.ReadLine()
		if err != nil {
			break
		}
		nameAndValue := bytes.SplitN(line, []byte(":"), 2)
		trailer.Add(string(nameAndValue[0]), string(nameAndValue[1]))
	}
	return trailer
}

func (r *responce) Reset() {
	r.fullResponce = r.fullResponce[:0]
}
