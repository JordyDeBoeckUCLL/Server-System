$TTL 300
$ORIGIN foobar.jordy-deboeck.sasm.uclllabs.be.
@       IN      SOA     foobar.jordy-deboeck.sasm.uclllabs.be. root.jordy-deboeck.sasm.uclllabs.be. (
                              2         ; Serial
                            300         ; Refresh
                            300         ; Retry
                            300         ; Expire
                          300 ) ; Negative Cache TTL
;name servers
        IN      NS      ns.jordy-deboeck.sasm.uclllabs.be.
ns      IN      A       193.191.177.221

test     IN      A    12.34.56.78
