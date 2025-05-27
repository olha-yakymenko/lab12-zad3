# syntax=docker/dockerfile:1

# Build stage with necessary dependencies
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN apk add --no-cache git gcc musl-dev
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o /output/hello .

# Final images
FROM alpine:3.18 AS linux
COPY --from=builder /output/hello /hello
CMD ["/hello"]

FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows
COPY --from=builder /output/hello.exe /hello.exe
CMD ["hello.exe"]

FROM ${TARGETOS} AS final