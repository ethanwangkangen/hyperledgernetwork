# Joins peer 0 of org 1 to channel

# Set envir variables for Peer0 of Org1
export PATH=${PWD}/../bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$PWD/.. # where configtx.yaml file is located.

export CORE_PEER_TLS_ENABLE=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH="../hyperledgernetwork/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp"
export CORE_PEER_ADDRESS="localhost:11051"
export CORE_PEER_TLS_CERT_FILE="../hyperledgernetwork/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt"
export CORE_PEER_TLS_KEY_FILE="../hyperledgernetwork/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key"
export CORE_PEER_TLS_ROOTCERT_FILE="../hyperledgernetwork/crypto-config/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem"
export ORDERER_ADDRESS="orderer.example.com:7047"

CHANNEL_NAME=mychannel

echo "Joining peer0.org1.example.com to the channel..."
peer channel join -b /home/wkangen/hlf/hyperledgernetwork/channel-artifacts/${CHANNEL_NAME}.block


