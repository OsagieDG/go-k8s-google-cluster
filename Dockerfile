FROM golang:1.21.0 as builder
WORKDIR /app

# Initialize a new Go module.
RUN go mod init go-k8s-google-cluster

# Copy local code to the container image.
COPY *.go ./

# Build the command inside the container.
RUN CGO_ENABLED=0 GOOS=linux go build -o /go-k8s-google-cluster

# Use a Docker multi-stage build to create a lean production image.
FROM gcr.io/distroless/base-debian11

# Change the working directory.
WORKDIR /

# Copy the binary to the production image from the builder stage.
COPY --from=builder /go-k8s-google-cluster /go-k8s-google-cluster

# Run the web service on container startup.
USER nonroot:nonroot
ENTRYPOINT ["/go-k8s-google-cluster"]

