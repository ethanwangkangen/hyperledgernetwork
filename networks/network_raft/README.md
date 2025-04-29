# Hyperledger Fabric Network Guide

This network consists of:
- **5 Orderers**
- **4 Peers** (2 in each organisation)
- **Raft consensus mechanism**

---

## Starting the Network

### 1. Start the Network

    ./network.sh x

- Shuts down any existing network and Docker containers.
- Pulls required Hyperledger Fabric (HLF) images (requires internet access).
- Brings up a new network using Docker Compose.

---

### 2. Join Channel and Deploy Chaincode

    ./joinChannels.sh

This script:
- Creates the channel.
- Joins all peers to the channel.
- Installs chaincode on all peers.
- Approves chaincode for both Org1 and Org2.
- Commits the chaincode.

Scripts for the above steps are located in `./channeljoinscripts`.

Now the chaincode should be ready to be invoked.

---

## Peer Environment Configuration

To act as a specific peer, set the peer environment variables:

    source ./setPeerEnv org<orgNumber> peer<peerNumber>

Example:

    source ./setPeerEnv org1 peer0

After setting the environment, you can run CLI commands like:

    peer lifecycle chaincode queryinstalled

---

## Test Chaincode Invocation

Run the test script to verify that chaincode invocation works:

    ./test.sh

---

## Run Caliper Benchmarks

### 1. Change to the Caliper Directory

    cd caliper

### 2. Run the Benchmark

    ./run.sh

### 3. Modify Benchmark Configuration

- Benchmark configurations are stored in the `/benchmark` directory.
- You can change:
  - The type of load applied
  - The number of workers used

To change the active configuration, edit `run.sh`.
