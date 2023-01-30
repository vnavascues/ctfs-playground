// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { SimpleTrick } from "ethernaut/28-gatekeeper-three/GatekeeperThree.sol";

interface IGatekeeperThree {
    receive() external payable;

    function construct0r() external;

    function createTrick() external;

    function enter() external returns (bool entered);

    function getAllowance(uint256 _password) external;

    function allow_enterance() external view returns (bool);

    function entrant() external view returns (address);

    function trick() external view returns (SimpleTrick);

    function owner() external view returns (address);
}
