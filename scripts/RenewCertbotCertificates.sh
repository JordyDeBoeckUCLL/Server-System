#!/bin/bash
FullDate=$(openssl x509 -in /etc/letsencrypt/live/jordy-deboeck.sasm.uclllabs.be/cert.pem -text -noout | grep After | cut -d':' -f2-4)
Date=$(date -d "$VolledigeVervaldatum" "+%d-%m-%Y")
Today=$(date +%d-%m-%Y)
if [ $Date == $Today ]; then
        certbot renew
else
        echo Certificate valid till $Date
fi
