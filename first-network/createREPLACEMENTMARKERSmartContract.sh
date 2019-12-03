#!/bin/bash

echo "parameters: $1 $2 $3 $4 $5"
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


sudo docker-compose -f docker-compose-cli-$REPLACEMENTMARKER.yaml down
read -p "Press [Enter] key"

export FABRIC_CFG_PATH=$PWD

#create channel
../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/$CHANNEL_NAME.tx -channelID $CHANNEL_NAME
read -p "Press [Enter] key"
#add anchor nodes to the channel
../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
read -p "Press [Enter] key"
../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP
read -p "Press [Enter] key"
sudo docker-compose -f docker-compose-cli-$REPLACEMENTMARKER.yaml up -d
sleep 20
sudo docker ps
read -p "Press [Enter] key"


#make sure the chaincode is in the chaincode dir ../chaincode/$CHAINCODE
sudo docker exec -it cli bash -c "/opt/gopath/src/github.com/hyperledger/fabric/peer/scripts/$REPLACEMENTMARKER-smartcontract-setup.sh $CHANNEL_NAME $CHAINCODE $CCODE_NAME $CCODE_NAME_VERSION"



#stop the docker nodes  sudo docker stop $(sudo docker ps -q -a)

#start the docker nodes  sudo docker start $(sudo docker ps -a -q)
~

