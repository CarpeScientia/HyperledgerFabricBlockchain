#!/bin/bash

#run with sudo docker exec cli 
echo "parameters: $1 $2 $3 $4"
if [ -z "$4" ] 
then
	echo "parameters are: CHANNEL_NAME  CHAINCODE-PATH  CONTRACT_NAME CONTRACT_VERSION"
	echo ""
	exit 1
fi
export CHANNEL_NAME=$1
export CHAINCODE=$2
export CCODE_NAME=$3
export CCODE_NAME_VERSION=$4
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/REPLACEMENTMARKER/orderers/orderer.REPLACEMENTMARKER/msp/tlscacerts/tlsca.REPLACEMENTMARKER-cert.pem

#--------

# this installs the Go chaincode. For go chaincode -p takes the relative path from $GOPATH/src
peer chaincode install -n $CCODE_NAME -v $CCODE_NAME_VERSION -p $CHAINCODE
read -p "Press [Enter] key"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.REPLACEMENTMARKER/users/Admin@org2.REPLACEMENTMARKER/msp 
CORE_PEER_ADDRESS=peer0.org2.REPLACEMENTMARKER:9051 
CORE_PEER_LOCALMSPID="Org2MSP" 
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.REPLACEMENTMARKER/peers/peer0.org2.REPLACEMENTMARKER/tls/ca.crt 

# this installs the Go chaincode. For go chaincode -p takes the relative path from $GOPATH/src
peer chaincode install -n $CCODE_NAME -v $CCODE_NAME_VERSION -p $CHAINCODE
read -p "Press [Enter] key"

# be sure to replace the $CHANNEL_NAME environment variable if you have not exported it
# if you did not install your chaincode with a name of $CCODE_NAME, then modify that argument as well

# peer chaincode instantiate -o orderer.REPLACEMENTMARKER:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/REPLACEMENTMARKER/orderers/orderer.REPLACEMENTMARKER/msp/tlscacerts/tlsca.REPLACEMENTMARKER-cert.pem -C $CHANNEL_NAME -n $CCODE_NAME -v $CCODE_NAME_VERSION -c '{"Args":["init"]}' -P "AND ('Org1MSP.peer','Org2MSP.peer')"

read -p "Press [Enter] key"

#-----------------

# Environment variables for PEER1 in Org2

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.REPLACEMENTMARKER/users/Admin@org2.REPLACEMENTMARKER/msp
CORE_PEER_ADDRESS=peer1.org2.REPLACEMENTMARKER:10051
CORE_PEER_LOCALMSPID="Org2MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.REPLACEMENTMARKER/peers/peer1.org2.REPLACEMENTMARKER/tls/ca.crt

peer chaincode install -n $CCODE_NAME -v $CCODE_NAME_VERSION -p $CHAINCODE

read -p "Press [Enter] key"

#-------------# Environment variables for PEER1 in Org1

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.REPLACEMENTMARKER/users/Admin@org1.REPLACEMENTMARKER/msp
CORE_PEER_ADDRESS=peer1.org1.REPLACEMENTMARKER:8051
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.REPLACEMENTMARKER/peers/peer1.org1.REPLACEMENTMARKER/tls/ca.crt

peer chaincode install -n $CCODE_NAME -v $CCODE_NAME_VERSION -p $CHAINCODE
read -p "Press [Enter] key"

peer chaincode upgrade -o orderer.REPLACEMENTMARKER:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CCODE_NAME -v $CCODE_NAME_VERSION -c '{"Args":["init"]}' -P "OR ('Org1MSP.peer','Org2MSP.peer')"

echo "DONE"

