#!/bin/bash
subdomain=$1
origin='$ORIGIN'
ttl='$TTL 300'
h1='"'
main='jordy-deboeck.sasm.uclllabs.be'
serial=$(cat /etc/bind/Zones/db.jordy-deboeck.sasm.uclllabs.be | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b');
newSerial=$(($serial + 1))

#we maken een zone file voor de subzone
echo "zone $h1$subdomain.$main$h1 {
type master;
file $h1/etc/bind/ScriptZones/db.$subdomain.jordy-deboeck.sasm.uclllabs.be$h1;
};
" >> /etc/bind/named.conf.mrt-zones

#we maken voor het subdomain een soa record
echo "$ttl
$origin $subdomain.jordy-deboeck.sasm.uclllabs.be.
@       IN      SOA     $subdomain.jordy-deboeck.sasm.uclllabs.be. root.jordy-deboeck.sasm.uclllabs.be. (
                              1         ; Serial
                            300         ; Refresh
                            300         ; Retry
                            300         ; Expire
                          300 ) ; Negative Cache TTL
;name servers
        IN      NS      ns.jordy-deboeck.sasm.uclllabs.be.
ns      IN      A       193.191.177.221
" > /etc/bind/ScriptZones/db.$subdomain.jordy-deboeck.sasm.uclllabs.be

#we voegen voor 	de subzone een ns record toe aan de main soa record en verhogen de serial
echo "$subdomain        IN      NS      ns.jordy-deboeck.sb.uclllabs.be." >> /etc/bind/Zones/db.jordy-deboeck.sasm.uclllabs.be
sed -i "s/$serial\t\t;\sSerial/$newSerial\t\t; Serial/" /etc/bind/Zones/db.jordy-deboeck.sasm.uclllabs.be

#we restarten named.service
sudo systemctl restart named.service;
