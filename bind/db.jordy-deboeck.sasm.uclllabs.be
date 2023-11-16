; BIND reverse data file for empty rfc1918 zone
;
; DO NOT EDIT THIS FILE - it is used for multiple zones.
; Instead, copy it, edit named.conf, and use that copy.
;
$TTL    300
$ORIGIN jordy-deboeck.sasm.uclllabs.be.
@       IN      SOA     jordy-deboeck.sasm.uclllabs.be. root.jordy-deboeck.sasm.uclllabs.be. (
                              1         ; Serial
                            300         ; Refresh
                            300         ; Retry
                            300         ; Expire
                          300 ) ; Negative Cache TTL
;name servers
        IN      NS      ns.jordy-deboeck.sasm.uclllabs.be.
        IN      NS      ns1.uclllabs.be.
        IN      NS      ns2.uclllabs.be.

;A records
@       IN      A       193.191.176.39
www     IN      A       193.191.176.39
ns      IN      A       193.191.176.39
ns1     IN      A       193.191.176.254
ns2     IN      A       193.191.177.4
test    IN      A       193.191.177.254

