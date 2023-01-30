// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IDelegation {
    // NB: unexistent function
    function pwn() external;

    function owner() external view returns (address);
}
