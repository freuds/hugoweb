---
title: "How to test SMTP servers"
date: 2020-06-08T08:06:25+06:00
hero: /posts/introduction/hero.svg
description: How to test SMTP servers using the command-line
menu:
  sidebar:
    name: How to test SMTP servers
    identifier: how-to-test-smtp-servers
    weight: 10
---

## DNS lookup

The first step is to find out which SMTP server(s) is responsible for the domain that you want to test, if you already know this you can skip this step. There are several command-line tools that can be used for this but here I’m using nslookup as well as dig as examples.

```shell
# dig example.local mx

(cut)
;; ANSWER SECTION:
example.local. 3600 IN MX 10 mx1.example.local.
example.local. 3600 IN MX 10 mx2.example.local.
(cut)
```

## Verify connnectivity

To verify if it’s possible to connect to the SMTP server you can use for example telnet or netcat.

```shell
# nc mx1.example.local 25
# telnet mx1.example.local 25

220 mx1.example.local ESMTP
```

## Test TLS

```shell
# openssl s_client -connect vsp1.example.local:25 -starttls smtp

(cut)
CONNECTED(00000003)
didn't found starttls in server response, try anyway...
139702030079656:error:140770FC:SSL routines:SSL23_GET_SERVER_HELLO:unknown protocol:s23_clnt.c:774:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 177 bytes and written 325 bytes
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
```


```shell
# openssl s_client -connect vsp2.example.local:25 -starttls smtp

(cut)
SSL-Session:
Protocol : TLSv1.2
Cipher : ECDHE-RSA-AES256-GCM-SHA384
Session-ID: 140C627F8364C06E74204CEHU61057415B1A24EC2E5D9B996C6F3277DB18F364
Session-ID-ctx:
Master-Key: C565114C052EDA50B176EA7962F415C3E2BD8A0FC62E243C592BB72164AAAE9625CE80EE81BF88FD8C480EAC4E20A74C
Key-Arg : None
PSK identity: None
PSK identity hint: None
SRP username: None
TLS session ticket lifetime hint: 300 (seconds)
TLS session ticket:
0000 - 73 04 63 bd 84 16 fd e4-a0 93 26 e0 71 3c 08 0b s.c.......&.qV)v.........
0070 - 19 08 d1 c2 14 ee da 69-cc 85 77 f6 13 39 3c f9 .......i..w..9<.
0080 - 8b 60 38 67 3c e9 f3 18-08 20 f6 1c 10 16 77 7f .`8gV.../..

Start Time: 1474028496
Timeout : 300 (sec)
Verify return code: 18 (self signed certificate)
```

## Test authentication

Setting up email clients just to verify that authentication is working can be a hassle, so it’s usually much quicker to test it using the command-line, but there are some things you need to be aware of.

First, you need to base64 encode the username and password that you want to test before connecting to the server. If you’re using a *NIX system you most likely have access to the base64 tool which you can use for this.

```shell
# echo -n "username" | base64
dXNlcm5hbWU=
# echo -n "password" | base64
cGFzc3dvcmQ=
```

```shell
(cut)
250 8BITMIME
AUTH LOGIN
334 VXNlcm5hbWU6
dXNlcm5hbWU=
334 UGFzc3dvcmQ6
cGFzc3dvcmQ=
235 2.7.0 Authentication successful
```

{{< mermaid >}}
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
    CUSTOMER }|..|{ DELIVERY-ADDRESS : uses
{{< /mermaid >}}