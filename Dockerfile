# syntax=docker/dockerfile:1

# Build stage
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS build
WORKDIR /app
COPY main.go .
RUN apk add --no-cache git
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o hello .

# Final stage - Linux
FROM alpine:3.18 AS linux
COPY --from=build /app/hello /hello
CMD ["/hello"]

# Final stage - Windows
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows
COPY --from=build /app/hello.exe /hello.exe
CMD ["hello.exe"]

# Select final image based on target
FROM ${TARGETOS} AS final