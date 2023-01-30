// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";

interface IForceAttacker {
    receive() external payable;

    function exploit(address _forceAddr) external;
}
