const fs = require('fs');
const { Wallets } = require('fabric-network');

async function main() {
    const wallet = await Wallets.newFileSystemWallet('./wallet');

    const certPath = './crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/signcerts/User1@org1.example.com-cert.pem';
    const keyPath = './crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/keystore/priv_sk';

    const cert = fs.readFileSync(certPath).toString();
    const key = fs.readFileSync(keyPath).toString();

    const identity = {
        credentials: { certificate: cert, privateKey: key },
        mspId: 'Org1MSP',
        type: 'X.509',
    };

    await wallet.put('User1', identity);
    console.log('Identity added to wallet');
}

main();
