#!/bin/bash

npm config set strict-ssl false

#npx caliper unbind
#rm -rf node_modules/@hyperledger/caliper-*
#rm -rf node_modules/caliper-*
#rm -f package-lock.json
#npm cache clean --force

# Bind FIRST before installing
#npx caliper bind --caliper-bind-sut fabric:fabric-gateway --caliper-bind-cwd ./
 
# Install dependencies AFTER binding
#npm install

# Run Caliper benchmark
npx caliper launch manager \
    --caliper-workspace ./ \
    --caliper-networkconfig networks/network-config.yaml  \
    --caliper-benchconfig benchmarks/config.yaml \
    --caliper-flow-only-test

