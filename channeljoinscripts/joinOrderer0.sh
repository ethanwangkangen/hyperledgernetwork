\osnadmin channel join --channelID mychannel --config-block config_block.pb -o orderer.example.com:7049 \
	--client-cert "../crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/Admin@example.com-cert.pem" \
	--client-key "../crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/keystore/priv_sk" \
	--ca-file  "../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" \
#	--ordererTLSHostnameOverride orderer.example.com

