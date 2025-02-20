export NETWORK_ROOT_PATH=$(pwd)
export PATH=${PWD}/bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$NETWORK_ROOT_PATH/orderer3 # where orderer.yaml for orderer3 is located.

cd bin
./orderer start
