#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $5)
    local CP=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$3/" \
        -e "s/\${CAPORT}/$4/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${CHANNEL_NAME}/$CHANNEL_NAME/" \
        ccp-template-REPLACEMENTMARKER.json 
}

function yaml_ccp {
    local PP=$(one_line_pem $5)
    local CP=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$3/" \
        -e "s/\${CAPORT}/$4/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${CHANNEL_NAME}/$CHANNEL_NAME/" \
        ccp-template-REPLACEMENTMARKER.yaml | sed -e $'s/\\\\n/\\\n        /g'
}

ORG=1
P0PORT=7051
P1PORT=8051
CAPORT=7054
PEERPEM=crypto-config/peerOrganizations/org1.REPLACEMENTMARKER/tlsca/tlsca.org1.REPLACEMENTMARKER-cert.pem
CAPEM=crypto-config/peerOrganizations/org1.REPLACEMENTMARKER/ca/ca.org1.REPLACEMENTMARKER-cert.pem

echo "$(json_ccp $ORG $P0PORT $P1PORT $CAPORT $PEERPEM $CAPEM)" > connection-org1-REPLACEMENTMARKER.json
echo "$(yaml_ccp $ORG $P0PORT $P1PORT $CAPORT $PEERPEM $CAPEM)" > connection-org1-REPLACEMENTMARKER.yaml

ORG=2
P0PORT=9051
P1PORT=10051
CAPORT=8054
PEERPEM=crypto-config/peerOrganizations/org2.REPLACEMENTMARKER/tlsca/tlsca.org2.REPLACEMENTMARKER-cert.pem
CAPEM=crypto-config/peerOrganizations/org2.REPLACEMENTMARKER/ca/ca.org2.REPLACEMENTMARKER-cert.pem

echo "$(json_ccp $ORG $P0PORT $P1PORT $CAPORT $PEERPEM $CAPEM)" > connection-org2-REPLACEMENTMARKER.json
echo "$(yaml_ccp $ORG $P0PORT $P1PORT $CAPORT $PEERPEM $CAPEM)" > connection-org2-REPLACEMENTMARKER.yaml
