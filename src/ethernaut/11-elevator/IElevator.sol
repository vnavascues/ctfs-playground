// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IElevator {
    function goTo(uint256 _floor) external;

    function floor() external view returns (uint256);

    function top() external view returns (bool);
}
