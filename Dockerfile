FROM golang:1.20 AS builder

WORKDIR /app

COPY go.mod ./
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o hello-go .

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/hello-go .

CMD ["./hello-go"]