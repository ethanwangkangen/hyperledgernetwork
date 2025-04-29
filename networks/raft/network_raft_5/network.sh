# This script brings up the network.


#!/bin/bash

# Set PATH to include the local bin directory
export PATH=${PWD}/bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$PWD # where configtx.yaml file is located.


# Function to start the network
function startNetwork() {
    echo "Starting the network..."

    # generate artifacts if they don't exist
#    if [ ! -d "organizations/peerOrganizations" ]; then
    generateCrypto

    cp crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/* crypto-config/peerOrganizations/org1.example.com/msp/admincerts/
    cp crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/* crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/admincerts/

    cp crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/signcerts/* crypto-config/peerOrganizations/org2.example.com/msp/admincerts/
    cp crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/signcerts/* crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/admincerts

    cp core.yaml crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com
    cp core.yaml crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com
    cp core.yaml crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com
    cp core.yaml crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com

    generateGenesis
    docker-compose -f docker-compose.yaml up -d

    generateChannel

    cd chaincode
    gradle build

    echo "Network started."
}

# Function to stop the network
function stopNetwork() {
    echo "Stopping the network..."

    # Stop and remove containers, networks, volumes, and images created by 'docker-compose up'
    docker-compose -f docker-compose.yaml down --volumes --remove-orphans

    # Ensure that all containers are stopped and removed
    docker rm -f $(docker ps -aq)  # Force remove all containers

    # Ensure that all unused networks are removed
    docker network prune -f

    # Ensure that all unused volumes are removed
    docker volume prune -f

    # Ensure that all unused images are removed
    docker rmi -f $(docker images -q)
    echo "Network stopped and cleaned up."

    rm -rf crypto-config
    rm -rf channel-artifacts

    rm -rf chaincode/build
}


# Function to generate cryptographic material
function generateCrypto() {
    echo "Generating cryptographic material..."
    cryptogen generate --config=./crypto-config.yaml --output="crypto-config"
    echo "Cryptographic material generated."
}

# Function to create genesis block/create application channel
function generateGenesis() {
    echo "Generating genesis block for channel..."
    rm -rf channel-artifacts
    mkdir channel-artifacts
#   configtxgen -profile ChannelUsingRaft -outputBlock ./system-genesis-block/genesis.block -channelID mychannel
    configtxgen -profile ChannelUsingRaft -outputBlock ./channel-artifacts/genesis.block -channelID system-channel # Genesis block
#    configtxgen -profile MyChannel -outputCreateChannelTx ./channel-artifacts/mychannel.tx -channelID mychannel # Application channel

}

function generateChannel() {
    configtxgen -profile MyChannel -outputCreateChannelTx ./channel-artifacts/mychannel.tx -channelID mychannel # Application channel
}



# Main entry point: check for the first argument ("up" or "down")
if [ "$1" == "createChannel" ]; then
    generateGenesis
fi
if [ "$1" == "up" ]; then
    startNetwork
elif [ "$1" == "down" ]; then
    stopNetwork
elif [ "$1" == "x" ]; then
	stopNetwork
	startNetwork
	docker ps
else
    echo "Usage: $0 {up|down}"
    exit 1
fi
