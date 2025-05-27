# syntax=docker/dockerfile:1

# Etap budowania (wspólny dla Linux/Windows)
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS build
WORKDIR /app
COPY main.go .
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o hello .

# Etap uruchomieniowy (Linux)
FROM alpine:3.18 AS linux
COPY --from=build /app/hello /hello
CMD ["/hello"]

# Etap uruchomieniowy (Windows)
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows
COPY --from=build /app/hello.exe /hello.exe
CMD ["hello.exe"]

# Wybór etapu w zależności od systemu docelowego
FROM ${TARGETOS} AS final