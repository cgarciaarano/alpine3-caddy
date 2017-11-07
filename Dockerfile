FROM golang:1.8 as builder
RUN go get github.com/mholt/caddy/caddy &&\
	go get github.com/caddyserver/builds &&\
	cd /go/src/github.com/mholt/caddy/caddy &&\
	CGO_ENABLED=0 GOOS=linux go run build.go


FROM alpine:3.5
LABEL authors="cgarciaarano@gmail.com"
COPY --from=builder /go/src/github.com/mholt/caddy/caddy/caddy /usr/bin
ENTRYPOINT ["/usr/bin/caddy"]
