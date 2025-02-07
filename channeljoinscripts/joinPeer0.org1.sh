# Creates the channel using peer0.org1
# Joins peer0.org1 to network with orderer0

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

# Create the channel by passing the transaction file
if peer channel create -o localhost:7049  --ordererTLSHostnameOverride orderer.example.com -c mychannel -f ../channel-artifacts/mychannel.tx --outputBlock ../channel-artifacts/mychannel.block --tls --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" ; then
	echo "Channel mychannel has been created successfully."
else
	echo "Problem creating channel."
fi


MAX_RETRIES=5  # Number of times to retry
RETRY_DELAY=5  # Delay in seconds between retries


for ((i=1; i<=MAX_RETRIES; i++)); do
    echo "Attempt $i: Joining channel..."#
	if peer channel join -b ../channel-artifacts/mychannel.block; then
		echo "Peer0.org1 has joined the channel successfully."
		break
	else
    	echo "Failed to join channel. Retrying in $RETRY_DELAY seconds..."
		sleep $RETRY_DELAY
	fi

done


peer channel list
peer channel getinfo -c mychannel

#peer channel fetch config config_block.pb -o localhost:7049 --ordererTLSHostnameOverride orderer.example.com -c mychannel --tls --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
#configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
#jq .data.data[0].payload.data.config.channel_group.groups.Application config_block.json

# Package the chaincode into mychaincode.tar.gz, will be inside this directory
peer lifecycle chaincode package mychaincode.tar.gz \
	--path ../chaincode/build/libs \
	--lang java \
	--label mychaincode_v1

# Install the chaincode on this peer
peer lifecycle chaincode install mychaincode.tar.gz

# Instantiate the chaincode (ie. install it on the channel)
peer chaincode instantiate -o localhost:7049 --channelID mychannel --ordererTLSHostnameOverride orderer.example.com --name mychaincode --version 1.0 --init-required -c '{"Args":["init","a","100","b","200"]}' --ctor '{"Args":["init","a","100","b","200"]}' --tls --cafile --cafile "./crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"


exit 1
