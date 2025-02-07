#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: source setPeerEnv.sh <org> <peer>"
    echo "Example: source setPeerEnv.sh org1 peer0"

fi

ORG=$1
PEER=$2

# Define peer address mapping
declare -A PEER_PORTS
PEER_PORTS["org1,peer0"]=11051
PEER_PORTS["org1,peer1"]=11054
PEER_PORTS["org2,peer0"]=13051
PEER_PORTS["org2,peer1"]=13054

PEER_PORT=${PEER_PORTS["$ORG,$PEER"]}
if [ -z "$PEER_PORT" ]; then
    echo "Invalid organization or peer."
fi

export PATH=${PWD}/bin:$PATH
export FABRIC_CFG_PATH=$PWD/
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="$(echo $ORG | sed -E 's/^(.)/\U\1/')MSP"
export CORE_PEER_TLS_ROOTCERT_FILE="crypto-config/peerOrganizations/$ORG.example.com/peers/$PEER.$ORG.example.com/tls/ca.crt"
export CORE_PEER_TLS_CERT_FILE="crypto-config/peerOrganizations/$ORG.example.com/peers/$PEER.$ORG.example.com/tls/server.crt"
export CORE_PEER_TLS_KEY_FILE="crypto-config/peerOrganizations/$ORG.example.com/peers/$PEER.$ORG.example.com/tls/server.key"
export CORE_PEER_ADDRESS=localhost:$PEER_PORT
export CORE_PEER_MSPCONFIGPATH="crypto-config/peerOrganizations/$ORG.example.com/users/Admin@$ORG.example.com/msp"
export CORE_PEER_LOGGING=INFO
export FABRIC_LOGGING=INFO

echo "Switched to $PEER of $ORG (PORT: $PEER_PORT)"
peer channel list
