FROM caddy:2.11.9-builder@sha256:cda07fe9d82728c7ac44d844306d435e98131423dc7b114f05a8a8ecfff94707 AS builder

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

FROM caddy:2.11.9-alpine@sha256:003a97808e781aa9f7e75cc2f43d34d461099031faf5e20faefb9f61126836f0

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
