// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IMagicNum {
    function setSolver(address _solver) external;

    function solver() external view returns (address);
}
