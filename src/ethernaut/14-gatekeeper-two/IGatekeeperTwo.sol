// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);

    function entrant() external view returns (address);
}
