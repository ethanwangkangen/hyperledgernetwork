# Network consisting of 5 orderers, 4 peers (in a single organisation), running BFT consensus mechanism.

----------------------------------------------------------
# [MUST DO]
# To start the network:
./network.sh x

# This brings down any existing network/docker containers/images, 
# brings up new docker images, pulling HLF images from online repo (thus needs internet access), 
# 'starts' peers and orderers (unqiue to HLF 3.0).


----------------------------------------------------------
# [MUST DO]
# Then to join everything to channel,
./joinChannels.sh

# This connects orderers to channel, joins peers to channel, installs chaincode on all peers, approves chaincode for Org1.
# Finally, commits chaincode.
# Scripts for all the above are in ./channeljoinscripts
# Now chaincode should be ready to be invoked.

----------------------------------------------------------
# To change the peer environment (which peer you are acting as),
source ./setPeerEnv org<x> peer<x>
eg: source ./setPeerEnv org1 peer0

# Then can run commands like
peer lifecycle queryinstalled

----------------------------------------------------------
# To test whether chaincode invokation works, 
./test.sh

----------------------------------------------------------
# To run caliper benchmarks,
cd caliper
./run.sh

# Benchmark configurations are in the /benchmark directory.
# Can modify type of loading used, number of workers.
# To change which configuration is used, modify run.sh
