export PATH=${PWD}/../bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$PWD/.. # where configtx.yaml file is located.
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt" # the cert of the CA that issued peer's tls
export CORE_PEER_TLS_CERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/server.crt"
export CORE_PEER_TLS_KEY_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/server.key"
export CORE_PEER_ADDRESS=localhost:13054 # check docker-compose.yaml for the port. Refers to the peer's port
export CORE_PEER_MSPCONFIGPATH="crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_LOGGING=DEBUG
export FABRIC_LOGGING=debug

# Commit the chaincode
peer lifecycle chaincode commit \
    -o localhost:7049 --ordererTLSHostnameOverride orderer.example.com \
    --channelID mychannel \
    --name mychaincode \
    --version 1.0 \
    --sequence 1 \
    --tls --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" \
    --peerAddresses localhost:11051 --tlsRootCertFiles ${PWD}/../crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt \
	--peerAddresses localhost:11054 --tlsRootCertFiles ${PWD}/../crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt \
    --peerAddresses localhost:13051 --tlsRootCertFiles ${PWD}/../crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt \
	--peerAddresses localhost:13054 --tlsRootCertFiles ${PWD}/../crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt \

