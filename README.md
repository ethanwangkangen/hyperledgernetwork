# Hyperledger Fabric Network Setup (Docker Environment)

This repository contains code to set up a Hyperledger Fabric (HLF) network within a Docker environment. Multiple network configurations are available, supporting different consensus mechanisms.

---

## Network Configurations

- Networks in the `/bft` folder use the **SmartBFT** consensus algorithm.
  - The number in the folder or filename (e.g., `network_bft_4`) indicates how many orderer nodes are configured.
- The network in the `/raft` folder uses the **RAFT** consensus algorithm.

> Note: BFT networks use a more recent version of the Hyperledger Fabric Docker images than the RAFT setup.

---

## Installation and Setup

Clone the repository with
```bash
git clone https://github.com/ethanwangkangen/hyperledgernetwork.git
```
Or simply extract the folder with [(https://github.com/ethanwangkangen/hyperledgernetwork/archive/refs/heads/main.zip)]

## Prerequisites (Assumed Linux environment)
Curl, Docker, git

```bash
sudo apt-get update
sudo apt-get install git curl docker-compose -y
```

May have to add user to Docker group.

```bash
sudo usermod -aG docker $USER
```

Make sure the Docker daemon is running.
```bash
sudo systemctl start docker
```

## Network Setup Instructions

### 1. Navigate to the Desired Network Folder

For example, to use the RAFT network with 5 orderers:

```bash
cd hyperledgernetwork/networks/raft/network_raft_5
```

---

### 2. Start the Network

Use the following command:

```bash
./network.sh {up | down | x}
```

- `up`: Start the network
- `down`: Tear down the network
- `x`: Tear down and restart (recommended for simplicity)

This script will:
- Generate cryptographic material (certs and keys)
- Create the genesis block and channel artifacts
- Start the network using Docker

> Recommended: use `./network.sh x` each time for a clean start.

---

### 3. Join Peers to the Channel

Run:

```bash
./joinChannels.sh
```

- This script behaves slightly differently depending on whether the underlying network is BFT or RAFT.
- The final output line should be:

```
=== Chaincode Committed ===
```

Once this appears, the network is ready to accept transactions.

---

## Chaincode Testing

To test a basic chaincode invocation:

```bash
./test.sh
```

This confirms that the network and chaincode are functioning correctly.

---

## Performance Testing with Caliper

### 1. Change to the Caliper Directory

```bash
cd caliper
```

### 2. Run the Benchmark

```bash
./run.sh
```

### 3. Modify Benchmark Configuration

- Benchmark files are located in the `/benchmark` directory.
- You may adjust:
  - Load profiles
  - Worker counts
  - Transaction parameters
- Changes to active testing configurations should be made in `run.sh`.

---

## Author

**Ethan Wang**
