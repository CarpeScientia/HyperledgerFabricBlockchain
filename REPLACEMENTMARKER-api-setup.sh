
# in fabric-samples/first-network/

./ccp-generate-REPLACEMENTMARKER.sh 

sudo docker-compose -f docker-compose-ca-REPLACEMENTMARKER.yaml up -d


#sudo docker logs -f --tail=200 ca_peerOrg1


sudo bash -c 'echo "127.0.0.1 peer0.org1.REPLACEMENTMARKER">> /etc/hosts'
sudo bash -c 'echo "127.0.0.1 peer0.org2.REPLACEMENTMARKER">> /etc/hosts'

sudo bash -c 'echo "127.0.0.1 peer1.org2.REPLACEMENTMARKER">> /etc/hosts'
sudo bash -c 'echo "127.0.0.1 peer1.org1.REPLACEMENTMARKER">> /etc/hosts'

sudo bash -c 'echo "127.0.0.1 orderer.REPLACEMENTMARKER">> /etc/hosts'


