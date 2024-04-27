---
title: Openssl Command
menu:
  notes:
    name: Openssl Command
    identifier: openssl-notes
    parent: system-notes
    weight: 20
---

{{< note title="Add CA on Centos/Debian/Ubuntu">}}
```bash
# Centos/RedHat
1. Copy the .crt file to /etc/pki/ca-trust/source/anchors on your CentOS machine
2. Run update-ca-trust extract
3. Check CA in list : cat /etc/pki/tls/certs/ca-bundle.trust.crt | grep SI2M

# Debian/Ubuntu
$ apt-get install -y ca-certificates
$ cp local-ca.crt /usr/local/share/ca-certificates
$ update-ca-certificates

# Get certificate from URL
openssl s_client -showcerts -verify 5 -connect stackexchange.com:443 < /dev/null
```
{{< /note >}}

{{< note title="Extract SSL from url">}}
```bash
openssl s_client -showcerts -verify 5 -connect wikipedia.org:443 < /dev/null |
   awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/{ if(/BEGIN CERTIFICATE/){a++}; out="cert"a".pem"; print >out}'
for cert in *.pem; do
    newname=$(openssl x509 -noout -subject -in $cert \
      | sed -nE 's/.*CN ?= ?(.*)/\1/; s/[ ,.*]/_/g; s/__/_/g; s/_-_/-/; s/^_//g;p' \
      | tr '[:upper:]' '[:lower:]').pem
    echo "${newname}"; mv "${cert}" "${newname}"
done
```
{{< /note >}}

{{< note title="KEY and CRT validation">}}
```bash
openssl pkey -in privateKey.key -pubout -outform pem | sha256sum
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum
```
{{< /note >}}


{{< note title="Tomcat SSL and Keystore">}}
```bash
#merge all certificats in one file PEM (CRT)
cat wildcard.domain.com.crt geotrust_CA_intermediate.crt geotrust_CA.crt > all.crt

#  convert CRT into P12 (PKCS12)
openssl pkcs12 -export -inkey wildcard.domain.com.key -in all.crt -name spotfire.domain.com -out spotfire.domain.com.p12

# import/export from P12
keytool -importkeystore -srckeystore spotfire.domain.com.p12 -srcstoretype pkcs12 -destkeystore spotfire.domain.com.jks

keytool -importkeystore -srckeystore spotfire.domain.com.jks -destkeystore spotfire.domain.com.jks -deststoretype pkcs12

## keytool -importkeystore -srckeystore spotfire.domain.com.p12 -srcstoretype pkcs12 -destkeystore spotfire.domain.com.jks
> Import du fichier de clés spotfire.domain.com.p12 vers spotfire.domain.com.jks...
Entrez le mot de passe du fichier de clés de destination :
Ressaisissez le nouveau mot de passe :
Entrez le mot de passe du fichier de clés source :
L'entrée de l'alias spotfire.domain.com a été importée.
Commande d'import exécutée : 1 entrées importées, échec ou annulation de 0 entrées

Warning:
Le fichier de clés JKS utilise un format propriétaire. Il est recommandé de migrer vers PKCS12,
qui est un format standard de l'industrie en utilisant :
"keytool -importkeystore -srckeystore spotfire.domain.com.jks -destkeystore spotfire.domain.com.jks -deststoretype pkcs12".
```
{{< /note >}}