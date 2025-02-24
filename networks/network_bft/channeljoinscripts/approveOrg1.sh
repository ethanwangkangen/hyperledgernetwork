export PATH=${PWD}/../bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$PWD/.. # where configtx.yaml file is located.
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" # the cert of the CA that issued peer's tls
export CORE_PEER_TLS_CERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt"
export CORE_PEER_TLS_KEY_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key"
export CORE_PEER_ADDRESS=localhost:11051
export CORE_PEER_MSPCONFIGPATH="crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_LOGGING=debug
export FABRIC_LOGGING=debug


peer channel fetch config config_block.pb -o localhost:7049 --ordererTLSHostnameOverride orderer.example.com -c mychannel --tls --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
jq .data.data[0].payload.data.config.channel_group.groups.Application config_block.json


# Package 
#peer lifecycle chaincode queryinstalled
PACKAGE_ID=$(peer lifecycle chaincode queryinstalled | awk -F': ' '/Package ID:/ {print $2}' | awk -F', ' '{print $1}' | head -n 1)
#PACKAGE_ID=$(peer lifecycle chaincode queryinstalled | awk -F'Package ID: ' '{print $2}' | awk -F',' '{print $1}' | awk -F':' '{print $2}')

#echo "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
#echo $PACKAGE_ID

peer lifecycle chaincode approveformyorg \
    -o localhost:7049 --ordererTLSHostnameOverride orderer.example.com \
    --channelID mychannel \
    --name mychaincode \
    --version 1.0 \
    --package-id $PACKAGE_ID \
    --sequence 1 \
    --tls \
    --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" \
#    --signature-policy "OR('Org1MSP.admin')"


#peer lifecycle chaincode queryapproved -C mychannel -n mychaincode --sequence 1 --output json
#peer lifecycle chaincode checkcommitreadiness -C mychannel -n mychaincode --sequence 1 --output json -v 1
#peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name mychaincode --version 1.0 --sequence 1 --tls --cafile "${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --output json

