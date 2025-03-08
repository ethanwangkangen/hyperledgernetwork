

# For the BFT version:
# Start by joining all the orderers to the channel
./orderer.sh
./orderer2.sh
./orderer3.sh
./orderer4.sh
./orderer5.sh

cd channeljoinscripts

./joinPeer0.org1.sh
sleep 5
./joinPeer1.org1.sh
sleep 5
./joinPeer2.org1.sh
sleep 5
./joinPeer3.org1.sh
sleep5


./installPeer0.org1.sh
sleep 20
./installPeer1.org1.sh
sleep 20
./installPeer2.org1.sh
sleep 20
./installPeer3.org1.sh
echo "================= All peers have joined the channel successfully ================="

sleep 30
./approveOrg1.sh
#./approveOrg2.sh


echo "================= Organisations approved ================="

sleep 60 # The above seems to take a while to approve chaincodes properly
./commitChaincode.sh

echo "================= Chaincode committed ================="

#peer lifecycle chaincode querycommitted --channelID mychannel --name mychaincode --cafile "${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"


