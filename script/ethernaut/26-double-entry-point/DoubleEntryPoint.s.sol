// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { IERC20 } from "@openzeppelin-contracts/token/ERC20/ERC20.sol";
import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { DelegateERC20 as IDelegateERC20, IForta } from "ethernaut/26-double-entry-point/DoubleEntryPoint.sol";
import { ICryptoVault } from "ethernaut/26-double-entry-point/ICryptoVault.sol";
import { IDoubleEntryPoint } from "ethernaut/26-double-entry-point/IDoubleEntryPoint.sol";
import { DetectionBot } from "ethernaut/26-double-entry-point/DetectionBot.sol";
import { ILegacyToken } from "ethernaut/26-double-entry-point/ILegacyToken.sol";

contract DoubleEntryPointScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address doubleEntryPointAddr = vm.envAddress("L26_DOUBLE_ENTRY_POINT_ADDRESS");
        IDoubleEntryPoint doubleEntryPoint = IDoubleEntryPoint(doubleEntryPointAddr);
        // console.log("*** DoubleEntryPoint");
        // console.logAddress(address(doubleEntryPoint));
        // console.logAddress(doubleEntryPoint.owner());

        // // CryptoVault
        // console.log("*** CryptoVault");
        // address cryptoVaultAddr = doubleEntryPoint.cryptoVault();
        // ICryptoVault cryptoVault = ICryptoVault(cryptoVaultAddr);
        // console.logAddress(address(cryptoVault));
        // console.logAddress(address(cryptoVault.underlying()));
        // console.logAddress(address(cryptoVault.sweptTokensRecipient()));

        // // LegacyToken
        // console.log("*** LegacyToken");
        // address legacyTokenAddr = doubleEntryPoint.delegatedFrom();
        // ILegacyToken legacyToken = ILegacyToken(legacyTokenAddr);
        // console.logAddress(address(legacyToken));
        // console.logAddress(address(legacyToken.delegate()));
        // console.logAddress(address(legacyToken.owner()));

        // // Player
        // console.log("*** Player");
        // address player = doubleEntryPoint.player();
        // console.logAddress(address(player));

        // // Forta
        // console.log("*** Forta");
        // IForta forta = doubleEntryPoint.forta();
        // console.logAddress(address(forta));

        // // Balances
        // console.log("*** Balances");
        // console.logUint(legacyToken.balanceOf(cryptoVaultAddr));
        // console.logUint(doubleEntryPoint.balanceOf(cryptoVaultAddr));

        // Step 1: deploy detection bot
        address cryptoVaultAddr = doubleEntryPoint.cryptoVault();
        bytes4 functionSignature = IDelegateERC20.delegateTransfer.selector;
        IForta forta = doubleEntryPoint.forta();
        DetectionBot detectionBot = new DetectionBot(cryptoVaultAddr, functionSignature, forta);

        // Step 2: set DetectionBot
        forta.setDetectionBot(address(detectionBot));

        // NB: uncomment out to test that it reverts
        // ICryptoVault cryptoVault = ICryptoVault(cryptoVaultAddr);
        // address legacyTokenAddr = doubleEntryPoint.delegatedFrom();
        // cryptoVault.sweepToken(IERC20(legacyTokenAddr));

        vm.stopBroadcast();
    }
}
