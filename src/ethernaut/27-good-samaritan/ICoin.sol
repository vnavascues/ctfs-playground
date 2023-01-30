// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Coin, Wallet } from "ethernaut/27-good-samaritan/GoodSamaritan.sol";

interface ICoin {
    function balances(address) external view returns (uint256);

    function transfer(address _dest, uint256 amount_) external;
}
