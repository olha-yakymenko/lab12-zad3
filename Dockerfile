# syntax=docker/dockerfile:1

##########################
# Etap 1: Budowanie binarki
##########################
FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .

RUN apk add --no-cache git

# Argumenty platformy
ARG TARGETOS
ARG TARGETARCH

# Ustawienia środowiska Go
ENV CGO_ENABLED=0 \
    GOOS=$TARGETOS \
    GOARCH=$TARGETARCH

# Kompilacja binarki Go
RUN go build -o /out/hello .

##############################
# Etap 2: Finalny obraz (Linux)
##############################
FROM alpine:3.18 AS linux

COPY --from=builder /out/hello /hello
ENTRYPOINT ["/hello"]

###################################
# Etap 2: Finalny obraz (Windows)
###################################
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS windows

COPY --from=builder /out/hello /hello.exe
ENTRYPOINT ["hello.exe"]
