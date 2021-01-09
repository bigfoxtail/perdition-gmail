# Perdition gmail proxy

use perdition to proxy gmail imap hosts 

# Description

fix ssl error (SNI Support), gmail server need it.

If you need the support of other domains, you can view these repositories:

* https://github.com/miguelwill/perdition-proxy

* https://github.com/guitarmarx/perdition-image

## QuickStart

Install Docker Compose

```
git clone https://github.com/bigfoxtail/perdition-gmail.git
cd perdition-gmail
sudo docker-compose up --build -d
```

* '/etc/perdition/perdition.crt.pem' - "file with certificate, you can leave the self-signed or upload a valid certificate"
* '/etc/perdition/perdition.key.pem' - "key file corresponding to the previous certificate"