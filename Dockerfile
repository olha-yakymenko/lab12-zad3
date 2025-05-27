# syntax=docker/dockerfile:1

# Build stage
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN apk add --no-cache git
# Only run go mod commands if go.mod exists
RUN if [ -f go.mod ]; then go mod download; fi
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /app/hello .

# Final images
FROM alpine:3.18 AS linux
COPY --from=builder /app/hello /hello
CMD ["/hello"]

FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows
COPY --from=builder /app/hello /hello.exe
CMD ["hello.exe"]

FROM ${TARGETOS} AS final