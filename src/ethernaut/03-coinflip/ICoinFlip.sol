// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);

    function consecutiveWins() external view returns (uint256);

    function lastHash() external view returns (uint256);
}
