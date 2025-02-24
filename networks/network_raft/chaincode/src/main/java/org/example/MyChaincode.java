package org.example;

import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.*;
import org.hyperledger.fabric.contract.Context;

import java.util.logging.Logger;

@Contract(name = "myChaincode") //change to myChaincode??
@Default
public class MyChaincode implements ContractInterface {
    
    private final Logger logger = Logger.getLogger(MyChaincode.class.getName());

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public void createAsset(Context ctx, String key, String value) {
        ctx.getStub().putStringState(key, value);
        logger.info("Asset created: " + key);
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String readAsset(Context ctx, String key) {
        return ctx.getStub().getStringState(key);
    }
}

