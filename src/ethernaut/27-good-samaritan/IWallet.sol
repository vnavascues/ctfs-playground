// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Coin } from "ethernaut/27-good-samaritan/GoodSamaritan.sol";

interface IWallet {
    function donate10(address _dest) external;

    function setCoin(Coin _coin) external;

    function transferRemainder(address _dest) external;

    function coin() external view returns (Coin);

    function owner() external view returns (address);
}
