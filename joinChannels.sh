cd channeljoinscripts

./joinPeer0.org1.sh
./joinPeer1.org1.sh
./joinPeer0.org2.sh
./joinPeer1.org2.sh

echo "================= All peers have joined the channel successfully ================="

./approveOrg1.sh
./approveOrg2.sh


echo "================= Organisations approved ================="

./commitChaincode.sh

echo "================= Chaincode committed ================="
