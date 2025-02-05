# Joins peer1.org1 to network with orderer0

export PATH=${PWD}/../bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$PWD/.. # where configtx.yaml file is located.
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_TLS_ROOTCERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt" # the cert of the CA that issued peer's tls
export CORE_PEER_TLS_CERT_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.crt"
export CORE_PEER_TLS_KEY_FILE="crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.key"
export CORE_PEER_ADDRESS=localhost:11054 # check docker-compose.yaml for the port
export CORE_PEER_MSPCONFIGPATH="crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_LOGGING=DEBUG
export FABRIC_LOGGING=debug

# Create the channel by passing the transaction file
#peer channel create -o localhost:7049  --ordererTLSHostnameOverride orderer.example.com -c mychannel -f ./channel-artifacts/mychannel.tx --outputBlock ./channel-artifacts/mychannel.block --tls --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"


MAX_RETRIES=5  # Number of times to retry
RETRY_DELAY=5  # Delay in seconds between retries
BLOCK_PATH="./channel-artifacts/mychannel.block"

for ((i=1; i<=MAX_RETRIES; i++)); do
    echo "Attempt $i: Joining channel..."#
        if peer channel join -b ../channel-artifacts/mychannel.block; then
                echo "Peer1.org1 has joined the channel successfully."
                break
        else
        echo "Failed to join channel. Retrying in $RETRY_DELAY seconds..."
                sleep $RETRY_DELAY
        fi

done


peer channel list
peer channel getinfo -c mychannel


exit 1
