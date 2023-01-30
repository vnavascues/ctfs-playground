// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IEngine {
    function horsePower() external returns (uint256);

    function initialize() external;

    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;

    function upgrader() external returns (address);
}

interface IMotorbike is IEngine {
    fallback() external payable;
}
