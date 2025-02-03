

export OSN_TLS_CA_ROOT_CERT="../crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem"
export ADMIN_TLS_SIGN_CERT="../crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/Admin@example.com-cert.pem"
export ADMIN_TLS_PRIVATE_KEY="../crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/keystore/priv_sk"

osnadmin channel join --channelID myblock --config-block ../channel-artifacts/genesis.block -o 0.0.0.0:7051 --ca-file $OSN_TLS_CA_ROOT_CERT --client-cert $ADMIN_TLS_SIGN_CERT --client-key $ADMIN_TLS_PRIVATE_KEY
