// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IInstance } from "ethernaut/00-hello-world/IInstance.sol";

contract HelloWorldScript is Script {
    function run() external payable {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address instanceAddr = vm.envAddress("L00_HELLO_WORLD_ADDRESS");
        IInstance instance = IInstance(instanceAddr);

        // Step 1: call `info()`
        console.log(instance.info());

        // Step 2: call `info1()`
        console.log(instance.info1());

        // Step 3: call `info2()` with "hello" as param
        console.log(instance.info2("hello"));

        // Step 4: call `infoNum()`
        console.log(instance.infoNum());

        // Step 5: call `info42()`
        console.log(instance.info42());

        // Step 6: call `theMethodName()`
        console.log(instance.theMethodName());

        // Step 7: call `method7123949()`
        console.log(instance.method7123949());

        // Step 8: call `password()`
        console.log(instance.password());

        // Step 8: call `authenticate()` with "ethernaut0" as param
        instance.authenticate(instance.password());

        vm.stopBroadcast();
    }
}
