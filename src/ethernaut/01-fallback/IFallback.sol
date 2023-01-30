// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IFallback {
    receive() external payable;

    function contribute() external payable;

    function withdraw() external;

    function getContribution() external view returns (uint256);
}
