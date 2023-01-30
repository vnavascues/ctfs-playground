// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { GatekeeperThree } from "ethernaut/28-gatekeeper-three/GatekeeperThree.sol";

interface ISimpleTrick {
    function checkPassword(uint256 _password) external returns (bool);

    function trickInit() external;

    function trickyTrick() external;

    function trick() external view returns (address);

    function target() external view returns (GatekeeperThree);
}
