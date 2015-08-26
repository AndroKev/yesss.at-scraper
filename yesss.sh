#!/bin/bash

rufnummer=""
passwort=""

html_data=`wget --post-data "login_rufnummer=$rufnummer&login_passwort=$passwort" -q -O - https://www.yesss.at/kontomanager.at/index.php?r=1`
if [ "$?" == 0 ]; then
    sguthhaben=`echo "$html_data" | grep 'Standardguthaben' -A 1 | grep -Po '(?<=(EUR )).*(?= <)'`
    # bguthhaben=`echo "$html_data" | grep 'Bonusguthaben' -A 1 | grep -Po '(?<=(EUR )).*(?=<)'`
    valid=`echo "$html_data" | grep 'SIM-Karte' -A 1 | grep -Po '(?<=(data-item.>)).*(?=<)'`
    datum=`date +%d.%m.%Y`
    echo "Standardguthaben: EUR $sguthhaben"
    # echo "Bonusguthaben.. : EUR $bguthhaben"
    echo "Gültig bis..... : $valid"
    echo "Stand.......... : $datum"
fi
