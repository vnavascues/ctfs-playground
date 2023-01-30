// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IPreservation {
    function setFirstTime(uint256 _timeStamp) external;

    function setSecondTime(uint256 _timeStamp) external;

    function timeZone1Library() external view returns (address);

    function timeZone2Library() external view returns (address);

    function owner() external view returns (address);
}
