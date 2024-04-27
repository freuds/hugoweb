---
title: Varnish
menu:
  notes:
    name: Varnish
    identifier: varnish-notes
    parent: networking-notes
    weight: 20
---

{{< note title="Tip et configuration">}}
```bash
# test la configuration
varnishd -C -f /etc/varnish/default.vcl
# Request sur les logs
varnishlog -q "RespStatus == 503" -g request
varnishlog -g request
```
{{< /note >}}

{{< note title="Examples">}}
```bash
# filter for 503 errors
varnishlog -q "RespStatus == 503" -g request
varnishlog -g request

# filter by request host header
varnishlog -q 'ReqHeader ~ "Host: example.com"'

# filter by request url
varnishlog -q 'ReqURL ~ "^/some/path/"'

# filter by client ip (behind reverse proxy)
varnishlog -q 'ReqHeader ~ "X-Real-IP: .*123.123.123.123"'

# filter by request host header and show request url and referrer header
varnishlog -q 'ReqHeader ~ "Host: (www\.)?example\.com"' -i "ReqURL" -I "ReqHeader:Referer:"

# filter for permanent redirects and show request host/url and new location
varnishlog -q "RespStatus ~ 301" -i "ReqURL" -I "ReqHeader:Host:" -I "RespHeader:Location:" -i "RespStatus"

# filter for permanent and temporary redirects and filter for Location "http://s3" to
# just show (for example) redirects to something on an Amazon S3 bucket
varnishlog -q '(RespStatus ~ 301 or RespStatus ~307) and RespHeader ~ "Location: https://s3"' \
   -i "ReqURL" -I "ReqHeader:Host:" -I "RespHeader:Location:" -i "RespStatus" -I "ReqHeader:Referer:"
```
{{< /note >}}


{{< note title="Gestion des 503">}}
```text
vcl 4.0;

backend default {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    if (req.url ~ "^/404") {
        return (synth(999, "make 404 error explicitly"));
    }
}

sub vcl_backend_response {
}

sub vcl_deliver {
}

sub vcl_backend_error {
    set beresp.http.Content-Type = "text/html; charset=utf-8";
    synthetic( {"errors due to backend fetch"} );
    return (deliver);
}

sub vcl_synth {
    if (resp.status == 999) {
        set resp.status = 404;
        set resp.http.Content-Type = "text/plain; charset=utf-8";
        synthetic({"errors due to vcl"});
        return (deliver);
    }
    return (deliver);
}
```
{{< /note >}}