#!/bin/bash
minTee=$1
soortRecord=$2

# We kijken eerst of er een -t meegegeven is
if [ $1 == "-t" ]; then
    # Zo ja, gaan we kijken wat voor soort record het is
    if [ $soortRecord == "A" ]; then
        # We zetten de variabelen
        naam=$3
        adres=$4
        volledigDocument=$5
        document=$(echo $volledigDocument | cut -d "." -f1)
        # We nemen de huidige serial en verhogen hem met 1
        serial=$(cat /etc/bind/ScriptZones/db.$document.jordy-deboeck.sasm.uclllabs.be | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b')
        newSerial=$(($serial + 1))
        # We voegen het A record toe
        echo "$naam     IN      $soortRecord    $adres" >> /etc/bind/ScriptZones/db.$document.jordy-deboeck.sasm.uclllabs.be
        # We verhogen de serial
        sed -i "s/$serial\s\s\s\s\s\s\s\s\s;\sSerial/$newSerial         ; Serial/" /etc/bind/ScriptZones/db.$document.jordy-deboeck.sasm.uclllabs.be
        # We restarten named.service
        sudo systemctl restart named.service
    elif [ $soortRecord == "CNAME" ]; then
        # We zetten de variabelen
        cname=$3
        host=$4
        # We nemen de huidige serial en verhogen hem met 1
        serial=$(cat /etc/bind/ScriptZones/db.$host | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b')
        newSerial=$(($serial + 1))
        # We voegen het CNAME record toe
        echo "$cname     IN      $soortRecord    $host." >> /etc/bind/ScriptZones/db.$host
        # We verhogen de serial
        sed -i "s/$serial\t\t;\sSerial/$newSerial\t\t; Serial/" /etc/bind/ScriptZones/db.$host
        # We restarten named.service
        sudo systemctl restart named.service
    elif [ $soortRecord == "MX" ]; then
        # We zetten de variabelen
        mail=$3
        ipadress=$4
        host=$5
        # We nemen de huidige serial en verhogen hem met 1
        serial=$(cat /etc/bind/ScriptZones/db.$host | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b')
        newSerial=$(($serial + 1))
        # We voegen het MX en A record toe
        echo "@ IN      $soortRecord    10      $mail.$host." >> /etc/bind/ScriptZones/db.$host
        echo "$mail     IN      A       $ipadress" >> /etc/bind/ScriptZones/db.$host
        # We verhogen de serial
        sed -i "s/$serial\t\t;\sSerial/$newSerial\t\t; Serial/" /etc/bind/ScriptZones/db.$host
        # We restarten named.service
        sudo systemctl restart named.service
    else
        echo "WRONG type of record"
    fi
else
    # Als er geen -t meegegeven is, gaan we standaard een A record toevoegen
    # We zetten de variabelen
    naam=$1
    adres=$2
    volledigDocument=$3
    document=$(echo $volledigDocument | cut -d "." -f1)
    # We nemen de huidige serial en verhogen hem met 1
    serial=$(cat /etc/bind/ScriptZones/db.$document.jordy-deboeck.sasm.uclllabs.be | grep -P 'Serial' | grep -P [0-9] | grep -oP '\b(?<!\.)\d+(?!\.)\b')
    newSerial=$(($serial + 1))
    # We voegen het A record toe
    echo "$naam     IN      A    $adres" >> /etc/bind/ScriptZones/db.$document.jordy-deboeck.sasm.uclllabs.be
    # We verhogen de serial
    sed -i "s/$serial\s\s\s\s\s\s\s\s\s;\sSerial/$newSerial         ; Serial/" /etc/bind/ScriptZones/db.$document.jordy-deboeck.sasm.uclllabs.be
    # We restarten named.service
    sudo systemctl restart named.service
fi
