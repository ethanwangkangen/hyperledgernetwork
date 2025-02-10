./network.sh up  #to start up the network
./network.sh createChannel #to create the channe
#?? to join nodes to channel

Updated: 07/02
./network.sh x to restart network (stop and start again). This also creates the channel material
./joinChannels.sh to use a peer to start the channel, then join all the peers to the channel


------------------------------------
# to add binaries to path
export PATH=${PWD}/bin:$PATH # where binaries are stored
export FABRIC_CFG_PATH=$PWD/config/ # where configtx.yaml is stored

-----------------------------------


# How to install chaincode
- MyChaincode.java inside chaincode/...../
- then ./gradlew build
- jar file should be inside build/libs
- then use a peer to package chaincode. peer lifecycle chaincode package mychaincode.tar.gz... (inside joinchannelscript)
- this creates the tar.gz file
- then install the chaincode with peer install ...

- this has been updated such that network.sh runs the gradle script to generate the files, then joinPeer0.org1.sh packages and installs the chaincode.
- the other joinPeerx.orgx.sh installs chaincode on the respective peers as well. 


# How to set environment variables properly
- source ./setPeerEnv.sh org1 peer0 # Important to have the source there as it makes it run in the same terminal and not a different one.


# Prometheus
- run Prometheus in a docker container, using docker-compose.yaml. Ensure that it is in the same network as the other nodes (fabric-network)
- configuration for prometheus is inside prometheus-docker/prometheus.yaml
