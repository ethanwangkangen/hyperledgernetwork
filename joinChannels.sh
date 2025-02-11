cd channeljoinscripts

./joinPeer0.org1.sh
sleep 2
./joinPeer1.org1.sh
sleep 2
./joinPeer0.org2.sh
sleep 2
./joinPeer1.org2.sh

echo "================= All peers have joined the channel successfully ================="

./approveOrg1.sh
./approveOrg2.sh


echo "================= Organisations approved ================="

sleep 60 # The above seems to take a while to approve chaincodes properly
./commitChaincode.sh

echo "================= Chaincode committed ================="
