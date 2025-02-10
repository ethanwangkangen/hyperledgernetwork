export PATH=${PWD}/../bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$PWD/.. # where configtx.yaml file is located.
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" # the cert of the CA that issued peer's tls
export CORE_PEER_TLS_CERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt"
export CORE_PEER_TLS_KEY_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key"
export CORE_PEER_ADDRESS=localhost:11051
export CORE_PEER_MSPCONFIGPATH="crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_LOGGING=INFO
export FABRIC_LOGGING=INFO

#peer lifecycle chaincode queryinstalled
PACKAGE_ID=$(peer lifecycle chaincode queryinstalled | awk -F': ' '/Package ID:/ {print $2}' | awk -F', ' '{print $1}' | head -n 1)


peer lifecycle chaincode approveformyorg \
        -o localhost:7049 --ordererTLSHostnameOverride orderer.example.com \
    --channelID mychannel \
    --name mychaincode \
    --version 1.0 \
    --package-id $PACKAGE_ID \
    --sequence 1 \
    --tls \
    --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" \

