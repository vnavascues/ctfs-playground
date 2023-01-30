// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IVault {
    function unlock(bytes32 _password) external;

    function locked() external view returns (bool);
}
