export PATH=${ROOTDIR}/bin:${PWD}/bin:$PATH
export ORDERER_CA=${PWD}/crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/server.key

osnadmin channel join --channelID mychannel --config-block ./channel-artifacts/genesis.block -o localhost:7063 \
        --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY"
