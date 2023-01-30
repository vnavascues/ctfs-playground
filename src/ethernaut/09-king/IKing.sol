// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IKing {
    receive() external payable;

    function _king() external view returns (address);

    function owner() external view returns (address);

    function prize() external view returns (uint256);
}
