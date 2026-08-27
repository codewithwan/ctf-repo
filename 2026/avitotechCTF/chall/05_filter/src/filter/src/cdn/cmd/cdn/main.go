package main

import (
	"flag"
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

var (
	rootDir string = "/www-data"
	port    uint   = 8080
)

func init() {
	flag.StringVar(&rootDir, "root", rootDir, "")
	flag.UintVar(&port, "port", port, "")
	flag.Parse()
}

func accessLogMiddle(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Info().
			Str("method", r.Method).
			Stringer("url", r.URL).
			Str("remote", r.RemoteAddr).
			Str("agent", r.UserAgent()).
			Send()

		next.ServeHTTP(w, r)
	})
}

func main() {
	log.Logger = log.Output(zerolog.NewConsoleWriter(func(w *zerolog.ConsoleWriter) {
		w.Out = os.Stdout
		w.TimeFormat = time.DateTime
	}))

	fileServer := FastFileServer{http.Dir(rootDir)}

	mux := http.NewServeMux()

	mux.Handle("/", http.RedirectHandler("/static/", http.StatusMovedPermanently))
	mux.Handle("/static/", accessLogMiddle(http.StripPrefix("/static/", fileServer)))
	mux.Handle("/ping", accessLogMiddle(http.HandlerFunc(PingPong)))

	protos := http.Protocols{}
	protos.SetHTTP1(true)
	protos.SetHTTP2(false)
	protos.SetUnencryptedHTTP2(false)

	server := &http.Server{
		Addr:      fmt.Sprintf(":%d", port),
		Handler:   mux,
		Protocols: &protos,
	}
	server.SetKeepAlivesEnabled(false)

	log.Info().
		Str("addr", server.Addr).
		Str("root", rootDir).
		Msg("Serving files...")

	if err := server.ListenAndServe(); err != nil {
		log.Fatal().Err(err).Send()
	}
}
