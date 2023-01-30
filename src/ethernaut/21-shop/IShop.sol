// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IShop {
    function buy() external;

    function price() external returns (uint256);

    function isSold() external returns (bool);
}
