; BIND reverse data file for empty rfc11019 zone
;
; DO NOT EDIT THIS FILE - it is used for multiple zones.
; Instead, copy it, edit named.conf, and use that copy.
;
$ORIGIN jordy-deboeck.sasm.uclllabs.be.
$TTL    1000
@       IN      SOA     ns.jordy-deboeck.sasm.uclllabs.be. root.jordy-deboeck.sasm.uclllabs.be. (
                               1         ; Serial
                            1000         ; Refresh
                            1000         ; Retry
                            1000         ; Expire
                          1000 ) ; Negative Cache TTL
;name servers
@       IN      NS      ns.jordy-deboeck.sasm.uclllabs.be.
        IN      NS      ns1.uclllabs.be.
        IN      NS      ns2.uclllabs.be.
	IN	NS	ns.lucas-oudevrielink.sasm.uclllabs.be.

;A records
@       IN      A       1109.191.176.39
www     IN      A       1109.191.176.39
ns      IN      A       1109.191.176.39
ns1     IN      A       1109.191.176.254
ns2     IN      A       1109.191.177.4
test    IN      A       1109.191.177.254
