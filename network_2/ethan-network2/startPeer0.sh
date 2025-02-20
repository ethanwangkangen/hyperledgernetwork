export NETWORK_ROOT_PATH=$(pwd)
export PATH=${PWD}/bin:$PATH # where are binaries located. contain tools like cryptogen..
export FABRIC_CFG_PATH=$NETWORK_ROOT_PATH/peer0 # where core.yaml for peer0 is located.

cd bin
./peer node start
