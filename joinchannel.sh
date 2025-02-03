#!/bin/bash

CHANNEL_NAME="mychannel"
ORDERER_ADDRESS="orderer.example.com:7047"
ORDERER_CA="./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt"

declare -A PEERS=(
	["Org1"]="peer0.org1.example.com:11051 peer1.org1.example.com:11054"
	["Org2"]="peer0.org2.example.com:13051 peer1.org2.example.com:13054"
)

declare -A MSP_PATHS=(
	["Org1"]="crypto-config/peerOrganizations/org1.example.com/msp"
	["Org2"]="crypto-config/peerOrganizations/org2.example.com/msp"
)

# Fetch the genesis block (only once)
function fetchGenesis(){ 
	echo "Fetching channel genesis block.."
	peer channel fetch 0 ./genesis_block.pb -o $ORDERER_ADDRESS \ 
	--ordererTLSHostnameOverride orderer.example.com \
    -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
}

fetchGenesis

# Loop through each org and join all peers

for ORG in "${!PEERS[@]}"; do
    echo "Joining peers for $ORG..."

    # Set the organization MSP
    export CORE_PEER_LOCALMSPID="${ORG}MSP"
    export CORE_PEER_MSPCONFIGPATH="${MSP_PATHS[$ORG]}"

    # Loop through peers in the organization
    for PEER in ${PEERS[$ORG]}; do
        export CORE_PEER_ADDRESS=$PEER

        echo "Joining $PEER to channel..."
        peer channel join -b ./genesis_block.pb

        # Verify if the peer joined successfully
        peer channel list
    done
done

echo "All peers have joined the channel!"


