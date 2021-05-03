# Build stage for production
FROM golang:alpine as builder
WORKDIR /go/src/sendir-rest/
COPY . .

RUN go build


# Execution stage for production
FROM alpine:latest as production
WORKDIR /root/
COPY --from=builder /go/src/sendir-rest .

CMD ["./sendir-rest"]


# Execution stage for development
FROM golang:latest as development
WORKDIR /go/src/sendir-rest/
RUN go install github.com/pilu/fresh@latest
EXPOSE 3001

CMD ["fresh"]
