# syntax=docker/dockerfile:1

# Build stage
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN apk add --no-cache git
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /hello .

# Final images
FROM alpine:3.18 AS linux-amd64
COPY --from=builder /hello /hello
CMD ["/hello"]

FROM alpine:3.18 AS linux-arm64
COPY --from=builder /hello /hello
CMD ["/hello"]

FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows-amd64
COPY --from=builder /hello /hello.exe
CMD ["hello.exe"]

# Select final image based on target platform
FROM ${TARGETOS}-${TARGETARCH} AS final