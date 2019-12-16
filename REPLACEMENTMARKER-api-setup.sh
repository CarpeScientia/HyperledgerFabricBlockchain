

echo "parameters: $1 $2 $3 $4"
if [ -z "$2" ]
then
        echo "parameters are: CHANNEL_NAME  CONTRACT_NAME "
        echo ""
        exit 1
fi
export CHANNEL_NAME=$1
export CCODE_NAME=$2

cd first-network/

export CA0KEY=$(ls -rt1 ./crypto-config/peerOrganizations/org1.REPLACEMENTMARKER.com/ca/|grep _sk|tail -n1)
export CA1KEY=$(ls -rt1 ./crypto-config/peerOrganizations/org2.REPLACEMENTMARKER.com/ca/|grep _sk|tail -n1)
export CAPASSWD=somepassword
# in fabric-samples/first-network/

./ccp-generate-REPLACEMENTMARKER.sh 

sudo -E docker-compose -f docker-compose-ca-REPLACEMENTMARKER.yaml up -d


#sudo docker logs -f --tail=200 ca_peerOrg1


sudo bash -c 'echo "127.0.0.1 peer0.org1.REPLACEMENTMARKER">> /etc/hosts'
sudo bash -c 'echo "127.0.0.1 peer0.org2.REPLACEMENTMARKER">> /etc/hosts'

sudo bash -c 'echo "127.0.0.1 peer1.org2.REPLACEMENTMARKER">> /etc/hosts'
sudo bash -c 'echo "127.0.0.1 peer1.org1.REPLACEMENTMARKER">> /etc/hosts'

sudo bash -c 'echo "127.0.0.1 orderer.REPLACEMENTMARKER">> /etc/hosts'


