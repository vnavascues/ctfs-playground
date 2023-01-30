// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IDenial {
    function setWithdrawPartner(address _partner) external;

    function withdraw() external;

    receive() external payable;

    function contractBalance() external view returns (uint256);

    function owner() external view returns (address);

    function partner() external view returns (address);
}
