export NETWORK_ROOT_PATH=$(pwd)
export PATH=${PWD}/bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$NETWORK_ROOT_PATH/orderer5 # where orderer.yaml for orderer5 is located.

cd bin
./orderer start
