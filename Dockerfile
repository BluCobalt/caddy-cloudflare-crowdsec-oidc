FROM caddy:2.11.7-builder@sha256:c4cd20eaa0b69112fd5d4f721ffc9671687e1d5d0b155c8620cf7546dbef94c0 AS builder

WORKDIR /src

COPY build/go.mod build/go.sum ./
RUN go mod download

COPY build/main.go ./
RUN CGO_ENABLED=0 go build \
    -trimpath \
    -buildvcs=false \
    -ldflags="-w -s" \
    -tags nobadger,nomysql,nopgx \
    -o /usr/bin/caddy \
    .

FROM caddy:2.11.7-alpine@sha256:e70b164da81ef698b3ad19af799ea6086ce6d9e48ed4079eb9fe26f6fbf14ee5

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
