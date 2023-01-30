// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface ITelephone {
    function changeOwner(address _owner) external;

    function owner() external;
}
