package main

import (
	"io"
	"net/http"
)

func PingPong(w http.ResponseWriter, r *http.Request) {
	io.Copy(w, r.Body)
}
