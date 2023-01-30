// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IMagicNum } from "ethernaut/18-magic-number/IMagicNum.sol";
import { Solver } from "ethernaut/18-magic-number/Solver.sol";

contract MagicNumScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address magicNumAddr = vm.envAddress("L18_MAGIC_NUMBER_ADDRESS");

        // Step 1: deploy `Solver`
        // NB: https://solidity-by-example.org/app/simple-bytecode-contract/
        new Solver(magicNumAddr);

        vm.stopBroadcast();
    }
}
