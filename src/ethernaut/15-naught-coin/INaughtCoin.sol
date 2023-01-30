// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin-contracts/token/ERC20/IERC20.sol";

interface INaughtCoin is IERC20 {
    function INITIAL_SUPPLY() external returns (uint256);

    function player() external returns (address);

    function timeLock() external returns (uint256);
}
