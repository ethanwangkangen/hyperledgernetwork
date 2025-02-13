'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

class CreateAssetWorkload extends WorkloadModuleBase {
    constructor() {
        super();
        this.txIndex = 0;
    }

    async initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext) {
        await super.initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext);
        this.assetPrefix = this.roundArguments.assetPrefix || 'asset';
    }

    async submitTransaction() {
        this.txIndex++;
        const assetKey = `${this.assetPrefix}_${this.workerIndex}_${this.txIndex}`;
        const assetValue = `value_${this.txIndex}`;

        const args = {
            contractId: 'myChaincode',
            contractFunction: 'createAsset',
            contractArguments: [assetKey, assetValue],
            timeout: 30,
        };

        await this.sutAdapter.sendRequests(args);
    }
}

function createWorkloadModule() {
    return new CreateAssetWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;

