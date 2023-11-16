#!/bin/bash
minTee=$1
soortRecord=$2
#we kijken eerst of er een -t meegegeven is
if [ $1 == "-t" ]; then
        #zo ja gaan we kijken wat voor soort record het is
        if [ $soortRecord == "A" ]; then
                #we zetten de variabelen
                naam=$3
                adres=$4
                volledigDocument=$5
                document=$(echo $volledigDocument | cut -d "." -f1)
                #we nemen de huidige serial en verhogen hem met 1
                serial=$(cat /etc/bind/Zones/db.$document.jordy-deboeck.sasm.uclllabs.be | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)>
                newSerial=$(($serial + 1))
                #we voegen het A record toe
                echo "$naam     IN      $soortRecord    $adres" >> /etc/bind/Zones/db.$document.jordy-deboeck.sasm.uclllabs.be;
                #we verhogen de serial
                sed -i "s/$serial\s\s\s\s\s\s\s\s\s;\sSerial/$newSerial         ; Serial/" /etc/bind/Zones/db.$document.jordy-deboeck.sasm.uclllabs.be
                #we restarten named.service
                sudo systemctl restart named.service
        elif [ $soortRecord == "CNAME" ]; then
                #we zetten de variabelen
                cname=$3
                host=$4
                #we nemen de huidige serial en verhogen hem met 1
                serial=$(cat /etc/bind/Zones/db.$host | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b');
                newSerial=$(($serial + 1))
                #we voegen het CNAME record toe
                echo "$cname     IN      $soortRecord    $host." >> /etc/bind/Zones/db.$host;
                #we verhogen de serial
                sed -i "s/$serial\t\t;\sSerial/$newSerial\t\t; Serial/" /etc/bind/Zones/db.$host;
                #we restarten named.service
                sudo systemctl restart named.service
        elif [ $soortRecord == "MX" ]; then
                #we zetten de variabelen
                mail=$3
                ipadress=$4
                host=$5
                #we nemen de huidige serial en verhogen hem met 1
		serial=$(cat /etc/bind/Zones/db.$host | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b');
                newSerial=$(($serial + 1))
                #we voegen het MX en A record toe
                echo "@ IN      $soortRecord    10      $mail.$host." >> /etc/bind/Zones/db.$host;
                echo "$mail     IN      A       $ipadress" >> /etc/bind/Zones/db.$host;
                #we verhogen de serial
                sed -i "s/$serial\t\t;\sSerial/$newSerial\t\t; Serial/" /etc/bind/Zones/db.$host
                #we restarten named.service
                sudo systemctl restart named.service
	else
                echo "WRONG type of record"
        fi

else
        #als er geen -t meegegeven is gaan we standaard een A record toevoegen
        #we zetten de variabelen
        naam=$1
        adres=$2
        volledigDocument=$3
        document=$(echo $volledigDocument | cut -d "." -f1)
        #we nemen de huidige serial en verhogen hem met 1
        serial=$(cat /etc/bind/Zones/db.$document.jordy-deboeck.sasm.uclllabs.be | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b');
        newSerial=$(($serial + 1))
        #we voegen het A record toe
        echo "$naam     IN      A    $adres" >> /etc/bind/Zones/db.$document.jordy-deboeck.sasm.uclllabs.be;
        #we verhogen de serial
        sed -i "s/$serial\s\s\s\s\s\s\s\s\s;\sSerial/$newSerial         ; Serial/" /etc/bind/Zones/db.$document.jordy-deboeck.sasm.uclllabs.be
        #we restarten named.service
        sudo systemctl restart named.service
fi
