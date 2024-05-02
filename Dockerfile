# Use an official Golang runtime as a parent image
FROM golang:1.21.0-alpine

# Set the working directory to /app
WORKDIR /app

# Copy go.mod and go.sum files to the container
COPY go.mod ./

# Download the dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN go build -o bin/app ./cmd/app

# Set the entry point of the container to the executable
CMD ["./bin/app"]

