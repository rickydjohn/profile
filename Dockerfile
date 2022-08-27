FROM golang:1.18 as base

RUN mkdir /app
COPY ./* /app/
WORKDIR /app

RUN go build -o /profile main.go

FROM ubuntu:20.04
COPY --from=base /profile /usr/local/bin/profile

ENTRYPOINT ["/usr/local/bin/profile"]
