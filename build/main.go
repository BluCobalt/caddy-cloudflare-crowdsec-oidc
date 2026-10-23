package main

import (
	_ "time/tzdata"

	caddycmd "github.com/caddyserver/caddy/v2/cmd"

	// Caddy standard modules.
	_ "github.com/caddyserver/caddy/v2/modules/standard"

	// Plugins.
	_ "github.com/caddy-dns/cloudflare"
	_ "github.com/caddyserver/transform-encoder"
	_ "github.com/hslatman/caddy-crowdsec-bouncer/appsec"
	_ "github.com/hslatman/caddy-crowdsec-bouncer/http"
	_ "github.com/hslatman/caddy-crowdsec-bouncer/layer4"
	_ "github.com/mholt/caddy-l4"
	_ "github.com/relvacode/caddy-oidc"
)

func main() {
	caddycmd.Main()
}
