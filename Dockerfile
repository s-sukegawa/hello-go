# Stage 1: Build the Go application
FROM golang:1.20 AS builder

WORKDIR /app

# Copy the go.mod and go.sum files
COPY go.mod go.sum ./

# Download all dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the Go application
RUN go build -o hello-go .

# Stage 2: Create the final image
FROM alpine:latest

WORKDIR /root/

# Copy the executable from the builder stage
COPY --from=builder /app/hello-go .

# Command to run the application
CMD ["./hello-go"]
