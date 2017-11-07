FROM golang:1.8 as builder
RUN go get github.com/mholt/caddy/caddy &&\
	go get github.com/caddyserver/builds &&\
	cd /go/src/github.com/mholt/caddy/caddy &&\
	CGO_ENABLED=0 GOOS=linux go run build.go


FROM alpine:3.5
LABEL authors="cgarciaarano@gmail.com"


# install tpl
RUN apk update && \
    apk add curl bash &&\
    curl -fsSLo /bin/tpl https://github.com/schneidexe/tpl/releases/download/v0.4.4/tpl-linux-amd64 && \
    chmod +x /bin/tpl && \
    tpl -v &&\
    apk del curl &&\
    rm -rf /var/cache/apk/*

COPY --from=builder /go/src/github.com/mholt/caddy/caddy/caddy /usr/local/bin/caddy

