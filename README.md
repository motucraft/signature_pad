# signature_pad

[syncfusion_flutter_pdfを利用しPDFへ電子署名する](https://zenn.dev/motu2119/articles/e6f42530abb21e)

## Create Cert (self-signed certificate)

### Create a key

```shell
$ openssl genrsa -out key.pem 2048
```

### Create certificate signin request

```shell
$ openssl req -new -sha256 -key key.pem -out csr.csr
```

### Create certificate

```shell
$ openssl req -x509 -sha256 -days 365 -key key.pem -in csr.csr -out certificate.pem
```

### Convert to .pfx file (PBE-SHA1-3DES Algorithm)

```shell
$ openssl pkcs12 -keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES -export -in certificate.pem -inkey key.pem -out certificate.pfx -name "alias"
```

## Application Behavior

https://github.com/motucraft/signature_pad/assets/35750184/cb0ee5b9-90ce-4e7c-890c-2c562136dbae

## Digitally signed PDF

![digitally_signed_pdf](https://github.com/motucraft/signature_pad/assets/35750184/7fbc42ce-71a6-4473-ad1f-fe4973e995e7)
