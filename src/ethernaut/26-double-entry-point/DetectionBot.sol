// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { IDetectionBot, IForta } from "ethernaut/26-double-entry-point/DoubleEntryPoint.sol";

contract DetectionBot is IDetectionBot {
    address private immutable i_msgSender;
    bytes4 private immutable i_functionSignature;
    IForta private immutable i_forta;

    constructor(address _msgSender, bytes4 _functionSignature, IForta _forta) {
        i_msgSender = _msgSender;
        i_functionSignature = _functionSignature;
        i_forta = _forta;
    }

    function handleTransaction(address _user, bytes calldata _msgData) external {
        (,, address origSender) = abi.decode(_msgData[4:], (address, uint256, address));
        bytes4 functionSignature = bytes4(_msgData[0:4]);
        if (origSender == i_msgSender && functionSignature == i_functionSignature) {
            i_forta.raiseAlert(_user);
        }
    }
}
