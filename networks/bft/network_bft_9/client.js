const { Gateway, Wallets } = require('fabric-network');
const fs = require('fs');
const path = require('path');

async function main() {
    try {
        // Load connection profile
        const ccpPath = path.resolve(__dirname, 'connection-profile.json');
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf8'));

        // Load the wallet containing User1
        const wallet = await Wallets.newFileSystemWallet('./wallet');

        // Check if the identity exists in the wallet
        const identity = await wallet.get('User1');
        if (!identity) {
            console.log('Identity "User1" not found in wallet');
            return;
        }

        // Create a new Gateway connection
        const gateway = new Gateway();
        await gateway.connect(ccp, {
            wallet,
            identity: 'User1',
            discovery: { enabled: true, asLocalhost: true }
        });

        // Get the network and contract
        const network = await gateway.getNetwork('mychannel');
        const contract = network.getContract('mychaincode');

        // Submit a transaction
        const result = await contract.submitTransaction('createAsset', 'arg1', 'arg2');
        console.log(`Transaction successful: ${result.toString()}`);

        // Disconnect from the gateway
        await gateway.disconnect();
    } catch (error) {
        console.error(`Error: ${error}`);
    }
}

main();
