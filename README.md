# signature_pad

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

## Signatured PDF

![signatured_pdf](https://github.com/motucraft/signature_pad/assets/35750184/05c37347-6431-45ba-891e-830ef383290a)
