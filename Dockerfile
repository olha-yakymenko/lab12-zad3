# syntax=docker/dockerfile:1

# Build stage
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN apk add --no-cache git
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /hello .

# Final image for Linux
FROM alpine:3.18 AS linux
COPY --from=builder /hello /hello
CMD ["/hello"]

# Final image for Windows
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows
COPY --from=builder /hello /hello.exe
CMD ["hello.exe"]

# Select final image based on target platform
FROM ${TARGETOS} AS final