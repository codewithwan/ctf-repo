FROM golang:1.26.4-alpine AS build-cdn

ENV CGO_ENABLED=0

COPY cdn/go.mod cdn/go.sum ./
RUN go mod download

COPY cdn/ .
RUN go build -o /cdn cdn/cmd/cdn

FROM golang:1.26.4-alpine AS build-hlp

ENV CGO_ENABLED=0

COPY hlp/go.mod hlp/go.sum ./
RUN go mod download

COPY hlp/ .
RUN go build -o /hlp honeyleakprevention/cmd/hlp

FROM alpine:3.24.0 AS prod

RUN apk add iptables supervisor

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisord.conf
COPY cdn/www-data /www-data

COPY --from=build-cdn /cdn /cdn
COPY --from=build-hlp /hlp /hlp


ENTRYPOINT ["supervisord"]
