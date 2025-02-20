
export NETWORK_ROOT_PATH=$(pwd)
export PATH=${PWD}/bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$NETWORK_ROOT_PATH # where configtx.yaml file is located.


cryptogen generate --config=./crypto-config.yaml --output="crypto-config"

