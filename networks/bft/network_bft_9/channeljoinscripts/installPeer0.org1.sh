export PATH=${PWD}/../bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$PWD/.. # where configtx.yaml file is located.
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" # the cert of the CA that issued peer's tls
export CORE_PEER_TLS_CERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt"
export CORE_PEER_TLS_KEY_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key"
export CORE_PEER_ADDRESS=localhost:11051
export CORE_PEER_MSPCONFIGPATH="crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_LOGGING=DEBUG
export FABRIC_LOGGING=DEBUG


#peer channel fetch config config_block.pb -o localhost:7049 --ordererTLSHostnameOverride orderer.example.com -c mychannel --tls --cafile "./crypto-config/ordererOrganizations/examp>
#configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
#jq .data.data[0].payload.data.config.channel_group.groups.Application config_block.json

# Package the chaincode into mychaincode.tar.gz, will be inside this directory
peer lifecycle chaincode package mychaincode.tar.gz \
        --path ../chaincode/build/libs \
        --lang java \
        --label mychaincode

# Install the chaincode on this peer
peer lifecycle chaincode install mychaincode.tar.gz

# Instantiate the chaincode (ie. install it on the channel) # Update: this seems to be depracated
# peer chaincode instantiate -o localhost:7049 --channelID mychannel --ordererTLSHostnameOverride orderer.example.com --name mychaincode --version 1.0 --init-required -c '{"Args":[">

