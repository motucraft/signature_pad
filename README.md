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

![digitally_signed_pdf](https://github.com/motucraft/signature_pad/assets/35750184/400ab67e-0332-4126-b0b9-47365571468c)

### Caution

This sample follows Syncfusion's example by utilizing certificate.pfx in the frontend.
However, certificate.pfx is an SSL certificate archive file where the private key and certificate are stored as a single file, meaning the private key would be exposed to the frontend.

Even if it's password-protected, this represents a risk of the private key being leaked, and it is something that should probably be avoided.
This process should be handled in the backend.
