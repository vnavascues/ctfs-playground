// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IPrivacy {
    function unlock(bytes16 _key) external;

    function ID() external view returns (uint256);

    function locked() external view returns (bool);
}
