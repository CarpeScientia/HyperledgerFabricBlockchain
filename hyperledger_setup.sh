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

sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install docker.io docker-compose golang nodejs  python screen -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version
# service docker status

#TODO replace all REPLACEMENTMARKER strings with the value of $REPLACEMENTMARKER


echo "hyperledger setup"
# clean source install from orignal github curl -sSL http://bit.ly/2ysbOFE | sudo bash -s
# cd fabric-samples/

cd first-network/

../bin/cryptogen generate --config=./crypto-config-$REPLACEMENTMARKER.yaml

export FABRIC_CFG_PATH=$PWD
#make backup of the unmodified yaml cp configtx.yaml configtx.yaml.orginal
cp configtx-$REPLACEMENTMARKER.yaml configtx.yaml

#create genesis block
../bin/configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block

./create$REPLACEMENTMARKERSmartContract.sh $CHANNEL_NAME $CHAINCODE $CCODE_NAME $CCODE_NAME_VERSION $REPLACEMENTMARKER
#stop the docker nodes  sudo docker stop $(sudo docker ps -q -a)

#start the docker nodes  sudo docker start $(sudo docker ps -a -q)
