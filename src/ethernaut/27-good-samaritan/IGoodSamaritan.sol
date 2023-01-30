// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Coin, Wallet } from "ethernaut/27-good-samaritan/GoodSamaritan.sol";

interface IGoodSamaritan {
    function requestDonation() external returns (bool);

    function coin() external view returns (Coin);

    function wallet() external view returns (Wallet);
}
