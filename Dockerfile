# syntax=docker/dockerfile:1

# Build stage
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN apk add --no-cache git
ARG TARGETOS
ARG TARGETARCH
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /output/app .

# Final images
FROM alpine:3.18 AS linux
COPY --from=builder /output/app /app
CMD ["/app"]

FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows
COPY --from=builder /output/app /app.exe
CMD ["app.exe"]

FROM ${TARGETOS} AS final