
source ./setPeerEnv.sh org1 peer0
peer lifecycle chaincode queryapproved -n mychaincode
peer chaincode invoke -o localhost:7049 --ordererTLSHostnameOverride orderer.example.com \
	--tls --cafile "${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" \
	-C mychannel \
	-n mychaincode \
	--peerAddresses localhost:11054 --tlsRootCertFiles "${PWD}/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt" \
	--peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/crypto-config/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/ca.crt" \
	-c '{"Args":["createAsset", "asset1", "value1 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"]}'
