#!/bin/bash



echo "parameters: $1 $2 $3 $4"
if [ -z "$5" ]
then
        printf "parameters are:
CHANNEL_NAME
CHAINCODE-PATH(as subdir from the chaincode dir)
CONTRACT_NAME
CONTRACT_VERSION
ORGANIZATION_DOMAIN(domain for the docker network)\n"
        echo ""
        exit 1
fi
export CHANNEL_NAME=$1
export CHAINCODE=$2
export CCODE_NAME=$3
export CCODE_NAME_VERSION=$4
export REPLACEMENTMARKER=$5


#make sure the code is in ../chaincode/$CHAINCODE
sudo docker exec -it cli bash -c "/opt/gopath/src/github.com/hyperledger/fabric/peer/scripts/update-$REPLACEMENTMARKER-smartcontract.sh $CHANNEL_NAME $CHAINCODE $CCODE_NAME $CCODE_NAME_VERSION"

#peer chaincode invoke -o orderer.REPLACEMENTMARKER:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/REPLACEMENTMARKER/orderers/orderer.REPLACEMENTMARKER/msp/tlscacerts/tlsca.REPLACEMENTMARKER-cert.pem -C $CHANNEL_NAME -n $CCODE_NAME --peerAddresses peer0.org1.REPLACEMENTMARKER:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.REPLACEMENTMARKER/peers/peer0.org1.REPLACEMENTMARKER/tls/ca.crt --peerAddresses peer0.org2.REPLACEMENTMARKER:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.REPLACEMENTMARKER/peers/peer0.org2.REPLACEMENTMARKER/tls/ca.crt -c '{"Args":["get","2019-11-21 15:04:05.999999999 -0700 MST"]}'

